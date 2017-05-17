///
/// \weakgroup parser_game GAME parser
/// @{
///

FUNC void AI_AimAt(VAR C_NPC Attacker, VAR C_NPC Target)
/// \brief      Start aiming with a ranged weapon (queued, overlay).
/// \param      Attacker
///                 Object reference to the character that aims at \p Target.
/// \param      Target
///                 Object reference to the character that \p Attacker aims at.
/// \details    The message is active as long as the \p Target is alive and
///             the \p Attacker still has ammunition for the ranged weapon.
///             Before checking for the ammunition the message handler is
///             waiting for the \p Attacker to draw the ranged weapon (bow or
///             crossbow). A message with high priority is queued to remove
///             the weapon if the \p Attacker has no ammunition.
/// \details    While the message is active and the animation state is AIM,
///             the turn animations are stopped and the aim animation is
///             interpolated to point at the \p Target. If the angle becomes
///             greater than 45 degrees, the \p Attacker loses the target lock
///             and starts turning to the \p Target.
/// \details    The \p Attacker is expected to be standing, because the message
///             handler requests a transition animation from WALK to AIM.
///             And the \p Attacker is forced into standing state when the
///             aiming is finalized.
/// \sa         AI_StopAim
/// \warning    In G2 the game will crash if \p Attacker is not a valid
///             character object reference.
/// \bug        In G1 the \p Attacker is not removed from the stack
///             if \p Target is not a valid character object reference.
{
};

FUNC void AI_AlignToFP(VAR C_NPC Character)
/// \brief      Align \p Character to an used spot (queued).
/// \param      Character
///                 Reference to the character object.
/// \details    The message handler is first searching for a spot that is
///             in use by the \p Character (in a 2 meters bounding box).
/// \details    If a used spot is found, the \p Character is turning to the
///             position that is 2 meters in front of the spot
///             until the angle is 1 degree or less.
/// \sa         AI_GotoFP
/// \sa         AI_GotoNextFP
/// \sa         Npc_IsOnFP
/// \sa         Wld_IsFPAvailable
/// \sa         Wld_IsNextFPAvailable
{
};

FUNC void AI_AlignToWP(VAR C_NPC Character)
/// \brief      Align \p Character to nearest waypoint (queued).
/// \param      Character
///                 Reference to the character object.
/// \details    The function searches for the nearest waypoint, calculates the
///             position that is 2 meters in front of the waypoint, and queues
///             a message for the \p Character to turn to that position.
/// \details    The message handler calculates the angle to the position and
///             turns the \p Character until the remaining angle is 0.
/// \sa         AI_GotoWP
/// \sa         Npc_GetDistToWP
/// \sa         Npc_GetNearestWP
/// \sa         Npc_GetNextWP
{
};

FUNC void AI_Ask(VAR C_NPC NonPlayer, VAR func OnYes, VAR func OnNo)
/// \brief      Wait for a player choice (queued).
/// \param      NonPlayer
///                 Object reference to the character.
/// \param      OnYes
///                 Function that is called when the player selects the
///                 first choice.
/// \param      OnNo
///                 Function that is called when the player selects the
///                 second choice.
/// \details    A choice dialog is displayed in the center of the screen
///             when the player is holding down the ACTION key while
///             this message is active and the \p NonPlayer is focused.
///             The selection in the dialog is made by using the
///             FORWARD key for the first choice ("Ja") or the
///             BACKWARD key for the second choice ("Nein").
/// \details    After the player selected the choice:
///             the global instance variable \b SELF is set to \p NonPlayer,
///             the global instance variable \b OTHER is set to the player,
///             and the script function \p OnYes or \p OnNo is called.
/// \note       Due to changes in the game controls, this feature is
///             broken in G2 and the player is not able to select the choice
///             (the first choice is immediately selected).
/// \sa         AI_AskText
/// \sa         AI_WaitForQuestion
{
};

FUNC void AI_AskText(VAR C_NPC NonPlayer, VAR func OnYes, VAR func OnNo, VAR string TextYes, VAR string TextNo)
/// \brief      Wait for a player choice (queued).
/// \param      NonPlayer
///                 Object reference to the character.
/// \param      OnYes
///                 Function that is called when the player selects the
///                 first choice.
/// \param      OnNo
///                 Function that is called when the player selects the
///                 second choice.
/// \param      TextYes
///                 String that is displayed for the first choice.
/// \param      TextNo
///                 String that is displayed for the second choice.
/// \details    A choice dialog is displayed in the center of the screen
///             when the player is holding down the ACTION key while
///             this message is active and the \p NonPlayer is focused.
///             The selection in the dialog is made by using the
///             FORWARD key for the first choice or the
///             BACKWARD key for the second choice.
/// \details    After the player selected the choice:
///             the global instance variable \b SELF is set to \p NonPlayer,
///             the global instance variable \b OTHER is set to the player,
///             and the script function \p OnYes or \p OnNo is called.
/// \note       Due to changes in the game controls, this feature is
///             broken in G2 and the player is not able to select the choice
///             (the first choice is immediately selected).
/// \sa         AI_Ask
/// \sa         AI_WaitForQuestion
{
};

FUNC void AI_Attack(VAR C_NPC Attacker)
/// \brief      Determine and queue the next fight action (direct).
/// \param      Attacker
///                 Object reference to the character.
/// \details    If the message queue for the \p Attacker is empty
///             (overlay messages are allowed/ignored)
///             and the \p Attacker has an enemy, the fight AI is used to
///             determine and queue the next fight action for the \p Attacker.
/// \details    Before determining the fight action, the game checks if
///             the \p Attacker is not swimming/diving and not in a weapon mode
///             (a message is queued to draw a weapon in the last mode) or if
///             the \p Attacker is in a ranged weapon mode (bow or crossbow)
///             and has no ammunition
///             (a message is queued to remove the weapon,
///             and another message is queued to equip the best weapon -
///             but without a weapon mode, therefore, without any effect).
/// \note       This function queues messages for the \p Attacker. Therefore,
///             subsequent calls are ignored until the queue is empty.
/// \sa         Npc_ClearAIQueue
/// \sa         Npc_GetTarget
/// \sa         Npc_GetNextTarget
/// \sa         Npc_IsNextTargetAvailable
/// \sa         Npc_SetTarget
{
};

FUNC void AI_CanSeeNpc(VAR C_NPC Character, VAR C_NPC Target, VAR func AIState)
/// \brief      Start AI state if a character object can be seen (queued).
/// \param      Character
///                 Object reference to the origin character.
/// \param      Target
///                 Object reference to the target character.
/// \param      AIState
///                 AI state that is started for the \p Character
///                 if the \p Target can be seen.
/// \details    The message handler clears the message queue of the \p Character
///             and immediately starts the \p AIState for the \p Character
///             (without waiting for the current AI state to end)
///             if the \p Character can see the \p Target.
/// \details    The \p Character can see the \p Target if the distance is
///             not greater than the \b C_NPC.senses_range of the \p Character,
///             there are no opaque static world polys between the objects,
///             and the angle to the \p Target is 90 degrees or less.
/// \note       A \p Target that is hiding in a barrel cannot be seen
///             (current interactive object is in state 1
///             and the scheme name contains the substring "BARREL").
/// \sa         Npc_CanSeeItem
/// \sa         Npc_CanSeeNpc
/// \sa         Npc_CanSeeNpcFreeLOS
{
};

FUNC void AI_CombatReactToDamage(VAR C_NPC Character)
/// \bug        The implementation leaves the \p Character on the stack.
{
};

FUNC void AI_ContinueRoutine(VAR C_NPC Character)
{
};

FUNC void AI_Defend(VAR C_NPC Character)
{
};

FUNC void AI_Dodge(VAR C_NPC Character)
{
};

FUNC void AI_DrawWeapon(VAR C_NPC Character)
{
};

FUNC void AI_DropItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void AI_DropMob(VAR C_NPC Character)
{
};

FUNC void AI_EquipArmor(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void AI_EquipBestArmor(VAR C_NPC Character)
{
};

FUNC int AI_EquipBestMeleeWeapon(VAR C_NPC Character)
/// \bug        The implementation does not push a result on the stack.
{
};

FUNC int AI_EquipBestRangedWeapon(VAR C_NPC Character)
/// \bug        The implementation does not push a result on the stack.
{
};

FUNC void AI_FinishingMove(VAR C_NPC Attacker, VAR C_NPC Target)
{
};

FUNC void AI_Flee(VAR C_NPC Character)
{
};

FUNC void AI_GotoFP(VAR C_NPC Character, VAR string NamePart)
/// \brief      Use and walk to the nearest free spot (queued).
/// \param      Character
///                 Reference to the character object.
/// \param      NamePart
///                 Substring that has to be present in the name of the spot
///                 (always converted to upper case).
/// \details    The message handler is searching for the nearest spot
///             (in a 14 meters bounding box) where the name of the spot
///             includes \p NamePart, that is available for the \p Character,
///             and that is in the free line of sight for the \p Character.
/// \details    If a valid spot is found, the spot is marked as in use by the
///             \p Character for 30 seconds, the \p Character is walking to
///             the spot (with a target variance of up to 50 centimetres),
///             and thereafter the \p Character is turning to the position
///             that is 2 meters in front of the spot until the angle is
///             less than 3 degrees.
/// \sa         AI_AlignToFP
/// \sa         AI_GotoNextFP
/// \sa         Npc_IsOnFP
/// \sa         Wld_IsFPAvailable
/// \sa         Wld_IsNextFPAvailable
{
};

FUNC void AI_GotoItem(VAR C_NPC Character, VAR C_Item Target)
{
};

FUNC void AI_GotoNextFP(VAR C_NPC Character, VAR string NamePart)
/// \brief      Use and walk to the next free spot (queued).
/// \param      Character
///                 Reference to the character object.
/// \param      NamePart
///                 Substring that has to be present in the name of the spot
///                 (always converted to upper case).
/// \details    The message handler is searching for any spot
///             (in a 14 meters bounding box) where the name of the spot
///             includes \p NamePart, that is available and not in use by
///             the \p Character, and that is in the free line of sight
///             for the \p Character.
/// \details    If a valid spot is found, the spot is marked as in use by the
///             \p Character for 30 seconds, the \p Character is walking to
///             the spot (with a target variance of up to 50 centimetres),
///             and thereafter the \p Character is turning to the position
///             that is 2 meters in front of the spot until the angle is
///             less than 3 degrees.
/// \sa         AI_AlignToFP
/// \sa         AI_GotoFP
/// \sa         Npc_IsOnFP
/// \sa         Wld_IsFPAvailable
/// \sa         Wld_IsNextFPAvailable
{
};

FUNC void AI_GotoNpc(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_GotoSound(VAR C_NPC Character)
{
};

FUNC void AI_GotoWP(VAR C_NPC Character, VAR string Name)
/// \brief      Use the waynet to walk to a waypoint (queued).
/// \param      Character
///                 Reference to the character object.
/// \param      Name
///                 Target waypoint name
///                 (the comparison is case sensitive, should be upper case).
/// \details    The message handler is first searching for a route from the
///             nearest waypoint to the target waypoint specified by \p Name.
/// \details    If the route has been found and created, the \p Character uses
///             the waynet to walk to the target waypoint (includes chasm and
///             climbing handling, and the automatic usage of ladder objects).
/// \sa         AI_AlignToWP
/// \sa         Npc_GetDistToWP
/// \sa         Npc_GetNearestWP
/// \sa         Npc_GetNextWP
{
};

FUNC void AI_LookAt(VAR C_NPC Character, VAR string TargetName)
{
};

FUNC void AI_LookAtNpc(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_Output(VAR C_NPC Character, VAR C_NPC Target, VAR string OuName)
{
};

FUNC void AI_OutputSVM(VAR C_NPC Character, VAR C_NPC Target, VAR string SvmName)
{
};

FUNC void AI_OutputSVM_Overlay(VAR C_NPC Character, VAR C_NPC Target, VAR string SvmName)
{
};

FUNC void AI_PlayAni(VAR C_NPC Character, VAR string AniName)
{
};

FUNC void AI_PlayAniBS(VAR C_NPC Character, VAR string AniName, VAR int NextBodyState)
{
};

FUNC void AI_PlayCutscene(VAR C_NPC Character, VAR string CsName)
{
};

FUNC void AI_PointAt(VAR C_NPC Character, VAR string TargetName)
{
};

FUNC void AI_PointAtNpc(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_ProcessInfos(VAR C_NPC NonPlayer)
{
};

FUNC void AI_QuickLook(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_ReadyMeleeWeapon(VAR C_NPC Character)
/// \bug        The implementation leaves an additional int (0) on the stack.
{
};

FUNC void AI_ReadyRangedWeapon(VAR C_NPC Character)
/// \bug        The implementation leaves an additional int (0) on the stack.
{
};

FUNC void AI_ReadySpell(VAR C_NPC Character, VAR int SpellId, VAR int ManaInvested)
{
};

FUNC void AI_RemoveWeapon(VAR C_NPC Character)
{
};

FUNC void AI_SetNpcsToState(VAR C_NPC Origin, VAR func AIState, VAR int Distance)
{
};

FUNC void AI_SetWalkMode(VAR C_NPC Character, VAR int WalkMode)
{
};

FUNC void AI_ShootAt(VAR C_NPC Attacker, VAR C_NPC Target)
{
};

FUNC void AI_StandUp(VAR C_NPC Character)
{
};

FUNC void AI_StandUpQuick(VAR C_NPC Character)
{
};

FUNC void AI_StartState(VAR C_NPC Character, VAR func AIState, VAR BOOL EndPrevState, VAR string WaypointName)
{
};

FUNC void AI_StopAim(VAR C_NPC Attacker)
/// \brief      Stop aiming with a ranged weapon (queued).
/// \param      Attacker
///                 Object reference to a character that aims at a target.
/// \details    Aiming is finalized and the \p Attacker is forced into standing
///             state.
/// \sa         AI_AimAt
/// \warning    In G2 the game will crash if \b Attacker is not a valid
///             character object reference.
{
};

FUNC void AI_StopLookAt(VAR C_NPC Character)
{
};

FUNC void AI_StopPointAt(VAR C_NPC Character)
{
};

FUNC void AI_StopProcessInfos(VAR C_NPC Character)
{
};

FUNC void AI_TakeItem(VAR C_NPC Character, VAR C_Item Target)
{
};

FUNC void AI_TakeMob(VAR C_NPC Character, VAR string SchemeName)
{
};

FUNC void AI_Teleport(VAR C_NPC Character, VAR string TargetName)
{
};

FUNC void AI_TurnAway(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_TurnToNPC(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_TurnToSound(VAR C_NPC Character)
{
};

FUNC void AI_UnequipArmor(VAR C_NPC Character)
{
};

FUNC void AI_UnequipWeapons(VAR C_NPC Character)
{
};

FUNC void AI_UnreadySpell(VAR C_NPC Character)
{
};

FUNC void AI_UseItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void AI_UseItemToState(VAR C_NPC Character, VAR C_ITEM_ID ItemId, VAR int TargetState)
{
};

FUNC BOOL AI_UseMob(VAR C_NPC Character, VAR string SchemeName, VAR int TargetState)
{
	return FALSE;
};

FUNC void AI_Wait(VAR C_NPC Character, VAR float Seconds)
{
};

FUNC void AI_WaitForQuestion(VAR C_NPC NonPlayer, VAR func OnQuestion)
/// \brief      Wait 20 seconds for a player question (queued).
/// \param      NonPlayer
///                 Object reference to the character.
/// \param      OnQuestion
///                 Function that is called when the player tries to
///                 talk to the \p NonPlayer character.
/// \details    If the player tries to talk to the \p NonPlayer while the
///             message is active:
///             the global instance variable \b SELF is set to \p NonPlayer,
///             the global instance variable \b OTHER is set to the player,
///             and the script function \p OnQuestion is called.
/// \note       If the player did not try to talk to the \p NonPlayer,
///             the message handler removes the message after the timeout,
///             sets the global instance variable \b SELF to \p NonPlayer,
///             and tries to call the script function \b B_NPCBye.
///             But the timeout callback is broken, because all symbol names
///             are converted to upper case during the parsing process, and
///             therefore the script function cannot be found.
/// \sa         AI_Ask
/// \sa         AI_AskText
{
};

FUNC void AI_Waitms(VAR C_NPC Character, VAR int Milliseconds)
{
};

FUNC void AI_WaitTillEnd(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_WhirlAround(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void AI_WhirlAroundToSource(VAR C_NPC Character)
{
};

FUNC string ConcatStrings(VAR string Str, VAR string Append)
{
	return "";
};

FUNC void CreateInvItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void CreateInvItems(VAR C_NPC Character, VAR C_ITEM_ID ItemId, VAR int Amount)
{
};

FUNC int Doc_Create() 
{
	return -1;
};

FUNC int Doc_CreateMap()
{
	return -1;
};

FUNC void Doc_Font(VAR string Font)
{
};

FUNC void Doc_MapCoordinates(VAR string LevelName, VAR float LevelLeft, VAR float LevelTop, VAR float TextureLeft, VAR float TextureTop, VAR float LevelRight, VAR float LevelBottom, VAR float TextureRight, VAR float TextureBottom)
{
};

FUNC void Doc_Open(VAR string Texture)
{
};

FUNC void Doc_Print(VAR string Text)
{
};

FUNC void Doc_PrintLine(VAR int Doc, VAR int Page, VAR string Text)
{
};

FUNC void Doc_PrintLines(VAR int Doc, VAR int Page, VAR string Text)
{
};

FUNC void Doc_SetFont(VAR int Doc, VAR int Page, VAR string Font)
{
};

FUNC void Doc_SetLevel(VAR int Doc, VAR string LevelName)
{
};

FUNC void Doc_SetMargins(VAR int Doc, VAR int Page, VAR int Left, VAR int Top, VAR int Right, VAR int Bottom, VAR BOOL SetMargin)
{
};

FUNC void Doc_SetPage(VAR int Doc, VAR int Page, VAR string Texture, VAR BOOL Scale)
{
};

FUNC void Doc_SetPages(VAR int Doc, VAR int PageCount)
{
};

FUNC void Doc_Show(VAR int Doc)
{
};

FUNC void EquipItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void ExitGame()
{
};

FUNC int FloatToInt(VAR float Value)
{
	return 0;
};

FUNC string FloatToString(VAR float Value)
{
	return "0.0";
};

FUNC int Hlp_CutscenePlayed(VAR string CSName)
{
	return 0;
};

FUNC C_VOB_ID Hlp_GetInstanceID(VAR C_VOB Object)
{
	return -1;
};

FUNC C_NPC Hlp_GetNpc(VAR C_NPC_ID NpcId)
{
	return NULL;
};

FUNC BOOL Hlp_IsItem(VAR C_Item ItemObject, VAR C_ITEM_ID ItemId)
{
	return FALSE;
};

FUNC BOOL Hlp_IsValidItem(VAR C_Item ItemObject)
{
	return FALSE;
};

FUNC BOOL Hlp_IsValidNpc(VAR C_NPC Character)
{
	return FALSE;
};

FUNC int Hlp_Random(VAR int Dividend)
{
	return 0;
};

FUNC BOOL Hlp_StrCmp(VAR string Str1, VAR string Str2)
{
	return FALSE;
};

FUNC void Info_AddChoice(VAR C_INFO_ID InfoId, VAR string ChoiceText, VAR func ChoiceFunc)
{
};

FUNC void Info_ClearChoices(VAR C_INFO_ID InfoId)
{
};

FUNC BOOL InfoManager_HasFinished()
{
	return TRUE;
};

FUNC void IntroduceChapter(VAR string Title, VAR string Text, VAR string Texture, VAR string SfxName, VAR int Milliseconds)
/// \bug        The implementation leaves an additional int (0) on the stack.
{
};

FUNC float IntToFloat(VAR int Value)
{
	return 0.0;
};

FUNC string IntToString(VAR int Value)
{
	return "0";
};

FUNC void Log_AddEntry(VAR string Topic, VAR string Entry)
{
};

FUNC void Log_CreateTopic(VAR string Topic, VAR int LogSection)
{
};

FUNC void Log_SetTopicStatus(VAR string Topic, VAR int TopicStatus)
{
};

FUNC void Mdl_ApplyOverlayMds(VAR C_NPC Character, VAR string AniOverlayName)
{
};

FUNC void Mdl_ApplyOverlayMdsTimed(VAR C_NPC Character, VAR string AniOverlayName, VAR int Milliseconds)
{
};

FUNC void Mdl_ApplyRandomAni(VAR C_NPC Character, VAR string StateAniName, VAR string RandomAniName)
{
};

FUNC void Mdl_ApplyRandomAniFreq(VAR C_NPC Character, VAR string RandomAniName, VAR float Seconds)
{
};

FUNC void Mdl_ApplyRandomFaceAni(VAR C_NPC Character, VAR string FaceAniName, VAR float MinTime, VAR float MinTimeVar, VAR float MaxTime, VAR float MaxTimeVar, VAR float MinProb)
{
};

FUNC void Mdl_RemoveOverlayMds(VAR C_NPC Character, VAR string AniOverlayName)
{
};

FUNC void Mdl_SetModelFatness(VAR C_NPC Character, VAR float ModelFatness)
{
};

FUNC void Mdl_SetModelScale(VAR C_NPC Character, VAR float ModelScaleX, VAR float ModelScaleY, VAR float ModelScaleZ)
{
};

FUNC void Mdl_SetVisual(VAR C_NPC Character, VAR string VisualName)
{
};

FUNC void Mdl_SetVisualBody(VAR C_NPC Character, VAR string Body, VAR int BodyNr, VAR int BodyClr, VAR string Head, VAR int HeadNr, VAR int TeethNr, VAR C_ITEM_ID ArmorId)
{
};

FUNC void Mdl_StartFaceAni(VAR C_NPC Character, VAR string FaceAniName, VAR float Intensity, VAR float Milliseconds)
{
};

FUNC void Mis_AddMissionEntry(VAR C_Mission Mission, VAR string Text)
/// \bug        The implementation removes an int instead of a C_Mission
///             from the stack.
{
};

FUNC int Mis_GetStatus(VAR C_MISSION_ID MissionId)
{
	return -1;
};

FUNC BOOL Mis_OnTime(VAR C_MISSION_ID MissionId)
/// \bug        The external is linked to \ref Mis_SetStatus.
{
	return FALSE;
};

FUNC void Mis_RemoveMission(VAR C_Mission Mission)
/// \bug        The implementation removes an int instead of a C_Mission
///             from the stack.
{
};

FUNC void Mis_SetStatus(VAR C_MISSION_ID MissionId, VAR int NewStatus)
{
};

FUNC void Mob_CreateItems(VAR string MobContainerName, VAR C_ITEM_ID ItemId, VAR int Amount)
{
};

FUNC int Mob_HasItems(VAR string MobContainerName, VAR C_ITEM_ID ItemId)
{
	return 0;
};

FUNC BOOL Npc_AreWeStronger(VAR C_NPC Character, VAR C_NPC Target)
{
	return FALSE;
};

FUNC BOOL Npc_CanSeeItem(VAR C_NPC Origin, VAR C_Item Target)
/// \brief      Checks if an item object can be seen (direct).
/// \param      Origin
///                 Object reference to the character.
/// \param      Target
///                 Object reference to the item.
/// \return     Returns TRUE if the \p Target can be seen by the \p Origin.
/// \details    The \p Origin can see the \p Target if the distance
///             is not greater than the \b C_NPC.senses_range of the \p Origin,
///             there are no opaque static world polys between the objects,
///             and the angle to the \p Target is 90 degrees or less.
/// \sa         AI_CanSeeNpc
/// \sa         Npc_CanSeeNpc
/// \sa         Npc_CanSeeNpcFreeLOS
{
	return FALSE;
};

FUNC BOOL Npc_CanSeeNpc(VAR C_NPC Origin, VAR C_NPC Target)
/// \brief      Checks if a character object can be seen (direct).
/// \param      Origin
///                 Object reference to the origin character.
/// \param      Target
///                 Object reference to the target character.
/// \return     Returns TRUE if the \p Target can be seen by the \p Origin.
/// \details    The \p Origin can see the \p Target if the distance
///             is not greater than the \b C_NPC.senses_range of the \p Origin,
///             there are no opaque static world polys between the objects,
///             and the angle to the \p Target is 90 degrees or less.
/// \note       A \p Target that is hiding in a barrel cannot be seen
///             (current interactive object is in state 1
///             and the scheme name contains the substring "BARREL").
/// \sa         AI_CanSeeNpc
/// \sa         Npc_CanSeeItem
/// \sa         Npc_CanSeeNpcFreeLOS
{
	return FALSE;
};

FUNC BOOL Npc_CanSeeNpcFreeLOS(VAR C_NPC Origin, VAR C_NPC Target)
/// \brief      Checks if a character is in free line of sight (direct).
/// \param      Origin
///                 Object reference to the origin character.
/// \param      Target
///                 Object reference to the target character.
/// \return     Returns TRUE if the \p Target is in free line of sight.
/// \details    The \p Target is in free line of sight if the distance
///             is not greater than the \b C_NPC.senses_range of the \p Origin,
///             and there are no opaque static world polys between the objects.
/// \note       A \p Target that is hiding in a barrel cannot be seen
///             (current interactive object is in state 1
///             and the scheme name contains the substring "BARREL").
/// \sa         AI_CanSeeNpc
/// \sa         Npc_CanSeeItem
/// \sa         Npc_CanSeeNpc
{
	return FALSE;
};

FUNC BOOL Npc_CanSeeSource(VAR C_NPC Character)
{
	return FALSE;
};

FUNC void Npc_ChangeAttribute(VAR C_NPC Character, VAR int Attribute, VAR int Value)
{
};

FUNC BOOL Npc_CheckAvailableMission(VAR C_NPC NonPlayer, VAR int Status, VAR BOOL Important)
{
	return FALSE;
};

FUNC BOOL Npc_CheckInfo(VAR C_NPC NonPlayer, VAR BOOL Important)
{
	return FALSE;
};

FUNC BOOL Npc_CheckOfferMission(VAR C_NPC NonPlayer, VAR BOOL Important)
{
	return FALSE;
};

FUNC BOOL Npc_CheckRunningMission(VAR C_NPC NonPlayer, VAR BOOL Important)
{
	return FALSE;
};

FUNC void Npc_ClearAIQueue(VAR C_NPC Character)
{
};

FUNC void Npc_CreateSpell(VAR C_NPC Character, VAR int SpellId)
{
};

FUNC BOOL Npc_DeleteNews(VAR C_NPC Character, VAR int NewsId)
{
	return FALSE;
};

FUNC void Npc_ExchangeRoutine(VAR C_NPC Character, VAR string RoutineName)
{
};

FUNC int Npc_GetActiveSpell(VAR C_NPC Character)
/// \bug        The implementation does not leave the result on the stack
///             if \p Character is not a valid character object reference.
{
	return -1;
};

FUNC int Npc_GetActiveSpellCat(VAR C_NPC Character)
/// \bug        The implementation does not leave the result on the stack
///             if \p Character is not a valid character object reference.
{
	return -1;
};

FUNC int Npc_GetActiveSpellLevel(VAR C_NPC Character)
/// \bug        The implementation does not leave the result on the stack
///             if \p Character is not a valid character object reference.
{
	return -1;
};

FUNC int Npc_GetAttitude(VAR C_NPC Character, VAR C_NPC Target)
/// \bug        The implementation does not leave the result on the stack
///             if \p Character or \p Target are invalid character references.
{
	return ATT_NEUTRAL;
};

FUNC int Npc_GetBodyState(VAR C_NPC Character)
{
	return 0;
};

FUNC int Npc_GetComrades(VAR C_NPC Character)
{
	return 0;
};

FUNC string Npc_GetDetectedMob(VAR C_NPC Character)
{
	return "NONE";
};

FUNC int Npc_GetDistToItem(VAR C_NPC Origin, VAR C_Item Target)
{
	return 2147483647;
};

FUNC int Npc_GetDistToNpc(VAR C_NPC Origin, VAR C_NPC Target)
{
	return 2147483647;
};

FUNC int Npc_GetDistToPlayer(VAR C_NPC Target)
{
	return 2147483647;
};

FUNC int Npc_GetDistToWP(VAR C_NPC Origin, VAR string Name)
/// \brief      Calculate the distance to a waypoint.
/// \param      Origin
///                 Reference to the character object.
/// \param      Name
///                 Target waypoint name
///                 (the comparison is case sensitive, should be upper case).
/// \return     Returns the distance in centimetres or 2147483647
///             if the \p Origin is not a valid character reference or
///             if no waypoint has been found by \p Name.
/// \sa         AI_AlignToWP
/// \sa         AI_GotoWP
/// \sa         Npc_GetNearestWP
/// \sa         Npc_GetNextWP
{
	return 2147483647;
};

FUNC C_Item Npc_GetEquippedArmor(VAR C_NPC Character)
{
	return NULL;
};

FUNC C_Item Npc_GetEquippedMeleeWeapon(VAR C_NPC Character)
{
	return NULL;
};

FUNC C_Item Npc_GetEquippedRangedWeapon(VAR C_NPC Character)
{
	return NULL;
};

FUNC int Npc_GetGuildAttitude(VAR C_NPC Character, VAR C_NPC Target)
{
	return ATT_NEUTRAL;
};

FUNC BOOL Npc_GetInvItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
	return FALSE;
};

FUNC int Npc_GetInvItemBySlot(VAR C_NPC Character, VAR int Category, VAR int Slot)
{
	return 0;
};

FUNC string Npc_GetNearestWP(VAR C_NPC Origin)
/// \brief      Returns the name of the nearest waypoint.
/// \param      Origin
///                 Reference to the character object.
/// \return     Returns the name of the nearest waypoint or an empty string
///             if the \p Origin is not a valid character reference or
///             if no waypoint has been found.
/// \sa         AI_AlignToWP
/// \sa         AI_GotoWP
/// \sa         Npc_GetDistToWP
/// \sa         Npc_GetNextWP
{
	return "";
};

FUNC C_NPC Npc_GetNewsOffender(VAR C_NPC Character, VAR int NewsId)
{
	return NULL;
};

FUNC C_NPC Npc_GetNewsVictim(VAR C_NPC Character, VAR int NewsId)
{
	return NULL;
};

FUNC C_NPC Npc_GetNewsWitness(VAR C_NPC Character, VAR int NewsId)
{
	return NULL;
};

FUNC BOOL Npc_GetNextTarget(VAR C_NPC Character)
{
	return FALSE;
};

FUNC string Npc_GetNextWP(VAR C_NPC Origin)
/// \brief      Returns the name of the second nearest waypoint.
/// \param      Origin
///                 Reference to the character object.
/// \return     Returns the name of the second nearest waypoint
///             or an empty string if the \p Origin is not a valid character
///             reference or if no waypoint has been found.
/// \sa         AI_AlignToWP
/// \sa         AI_GotoWP
/// \sa         Npc_GetDistToWP
/// \sa         Npc_GetNearestWP
{
	return "";
};

FUNC int Npc_GetPermAttitude(VAR C_NPC Character, VAR C_NPC Target)
/// \bug        The implementation does not leave the result on the stack
///             if \p Character or \p Target are invalid character references.
{
	return ATT_NEUTRAL;
};

FUNC C_Item Npc_GetReadiedWeapon(VAR C_NPC Character)
{
	return NULL;
};

FUNC int Npc_GetStateTime(VAR C_NPC Character)
{
	return 0;
};

FUNC int Npc_GetTalentSkill(VAR C_NPC Character, VAR int Talent)
{
	return 0;
};

FUNC int Npc_GetTalentValue(VAR C_NPC Character, VAR int Talent)
{
	return 0;
};

FUNC BOOL Npc_GetTarget(VAR C_NPC Character)
{
	return FALSE;
};

FUNC int Npc_GetTrueGuild(VAR C_NPC Character)
{
	return 0;
};

FUNC BOOL Npc_GiveInfo(VAR C_NPC NonPlayer, VAR BOOL Important)
{
	return FALSE;
};

FUNC void Npc_GiveItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId, VAR C_NPC Target)
{
};

FUNC BOOL Npc_HasBodyFlag(VAR C_NPC Character, VAR int BodyStates)
{
	return FALSE;
};

FUNC BOOL Npc_HasDetectedNpc(VAR C_NPC NonPlayer, VAR C_NPC Target)
/// \bug        The implementation does not leave the result on the stack
///             if \p NonPlayer or \p Target are invalid character references.
{
	return FALSE;
};

FUNC BOOL Npc_HasEquippedArmor(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasEquippedMeleeWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasEquippedRangedWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasEquippedWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC int Npc_HasItems(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
	return 0;
};

FUNC int Npc_HasNews(VAR C_NPC Character, VAR int NewsId, VAR C_NPC NewsOffender, VAR C_NPC NewsVictim)
{
	return 0;
};

FUNC BOOL Npc_HasOffered(VAR C_NPC Character, VAR C_NPC Player, VAR C_ITEM_ID ItemId)
{
	return FALSE;
};

FUNC BOOL Npc_HasRangedWeaponWithAmmo(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasReadiedMeleeWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasReadiedRangedWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasReadiedWeapon(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_HasSpell(VAR C_NPC Character, VAR int SpellId)
{
	return FALSE;
};

FUNC BOOL Npc_IsAiming(VAR C_NPC Attacker, VAR C_NPC Target)
{
	return FALSE;
};

FUNC BOOL Npc_IsDead(VAR C_NPC Character)
{
	return TRUE;
};

FUNC BOOL Npc_IsDetectedMobOwnedByGuild(VAR C_NPC Character, VAR int Guild)
{
	return FALSE;
};

FUNC BOOL Npc_IsDetectedMobOwnedByNpc(VAR C_NPC Character, VAR C_NPC Owner)
{
	return FALSE;
};

FUNC BOOL Npc_IsInCutscene(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_IsInFightMode(VAR C_NPC Character, VAR int WeaponMode)
{
	return FALSE;
};

FUNC BOOL Npc_IsInRoutine(VAR C_NPC Character, VAR func Routine)
{
	return FALSE;
};

FUNC BOOL Npc_IsInState(VAR C_NPC Character, VAR func AIState)
{
	return FALSE;
};

FUNC BOOL Npc_IsNear(VAR C_NPC Origin, VAR C_NPC Target)
{
	return FALSE;
};

FUNC BOOL Npc_IsNewsGossip(VAR C_NPC Character, VAR int NewsId)
{
	return FALSE;
};

FUNC BOOL Npc_IsNextTargetAvailable(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_IsOnFP(VAR C_NPC Character, VAR string NamePart)
/// \brief      Check if \p Character is near a used spot.
/// \param      Character
///                 Reference to the character object.
/// \param      NamePart
///                 Substring that has to be present in the name of the spot
///                 (the comparison is case sensitive, should be upper case).
/// \return     Returns TRUE if the \p Character is using the nearest spot.
/// \details    The message handler is searching for the nearest spot
///             (in a 2 meters bounding box) where the name of the spot
///             includes \p NamePart, that is available for the \p Character,
///             and that is in the free line of sight for the \p Character.
/// \note       If the \p Character is currently using the spot, the spot is
///             made available again for usage if the \p Character is currently
///             not inside a 1x2x1 meter bounding box of the spot.
/// \sa         AI_AlignToFP
/// \sa         AI_GotoFP
/// \sa         AI_GotoNextFP
/// \sa         Wld_IsFPAvailable
/// \sa         Wld_IsNextFPAvailable
{
	return FALSE;
};

FUNC BOOL Npc_IsPlayer(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_IsPlayerInMyRoom(VAR C_NPC Owner)
{
	return FALSE;
};

FUNC BOOL Npc_IsVoiceActive(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_IsWayBlocked(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_KnowsInfo(VAR C_NPC Character, VAR C_INFO_ID InfoId)
{
	return FALSE;
};

FUNC BOOL Npc_KnowsPlayer(VAR C_NPC Character, VAR C_NPC Player)
{
	return FALSE;
};

FUNC void Npc_LearnSpell(VAR C_NPC Character, VAR int SpellId)
{
};

FUNC void Npc_MemoryEntry(VAR C_NPC Witness, VAR BOOL Gossip, VAR C_NPC Offender, VAR int NewsId, VAR C_NPC NewsVictim)
{
};

FUNC void Npc_MemoryEntryGuild(VAR C_NPC Witness, VAR BOOL Gossip, VAR C_NPC Offender, VAR int NewsId, VAR C_NPC NewsVictim)
{
};

FUNC BOOL Npc_OwnedByGuild(VAR C_Item ItemObject, VAR int Guild)
{
	return FALSE;
};

FUNC BOOL Npc_OwnedByNpc(VAR C_Item ItemObject, VAR C_NPC Owner)
{
	return FALSE;
};

FUNC void Npc_PercDisable(VAR C_NPC Character, VAR int PerceptionId)
{
};

FUNC void Npc_PerceiveAll(VAR C_NPC NonPlayer)
{
};

FUNC void Npc_PercEnable(VAR C_NPC Character, VAR int PerceptionId, VAR func OnPerception)
{
};

FUNC void Npc_PlayAni(VAR C_NPC Character, VAR string AniName)
{
};

FUNC BOOL Npc_RefuseTalk(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Npc_RemoveInvItem(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
	return FALSE;
};

FUNC BOOL Npc_RemoveInvItems(VAR C_NPC Character, VAR C_ITEM_ID ItemId, VAR int Amount)
{
	return FALSE;
};

FUNC void Npc_SendPassivePerc(VAR C_NPC Character, VAR int PerceptionId, VAR C_NPC PercVictim, VAR C_NPC Offender)
{
};

FUNC void Npc_SendSinglePerc(VAR C_NPC Origin, VAR C_NPC Target, VAR int PerceptionId)
{
};

FUNC int Npc_SetActiveSpellInfo(VAR C_NPC Character, VAR int TransformInstance)
/// \bug        The implementation does not leave the result on the stack.
{
	return 0;
};

FUNC void Npc_SetAttitude(VAR C_NPC Character, VAR int Attitude)
{
};

FUNC void Npc_SetKnowsPlayer(VAR C_NPC Character, VAR C_NPC Player)
{
};

FUNC void Npc_SetPercTime(VAR C_NPC Character, VAR float Seconds)
{
};

FUNC void Npc_SetRefuseTalk(VAR C_NPC Character, VAR int Seconds)
{
};

FUNC void Npc_SetStateTime(VAR C_NPC Character, VAR int Seconds)
{
};

FUNC void Npc_SetTalentSkill(VAR C_NPC Character, VAR int Talent, VAR int Skill)
/// \bug        The implementation leaves an additional int (Hlp_IsValidNpc)
///             on the stack.
{
};

FUNC void Npc_SetTalentValue(VAR C_NPC Character, VAR int Talent, VAR int Value)
/// \bug        The implementation leaves an additional int (Hlp_IsValidNpc)
///             on the stack.
{
};

FUNC void Npc_SetTarget(VAR C_NPC Character, VAR C_NPC Target)
{
};

FUNC void Npc_SetTempAttitude(VAR C_NPC Character, VAR int Attitude)
{
};

FUNC void Npc_SetToFightMode(VAR C_NPC Character, VAR C_ITEM_ID ItemId)
{
};

FUNC void Npc_SetToFistMode(VAR C_NPC Character)
{
};

FUNC int Npc_SetTrueGuild(VAR C_NPC Character, VAR int Guild)
/// \bug        The implementation does not leave a result on the stack.
{
	return 0;
};

FUNC BOOL Npc_StartItemReactModules(VAR C_NPC Taker, VAR C_NPC Giver, VAR C_Item ItemObject)
{
	return FALSE;
};

FUNC BOOL Npc_WasInState(VAR C_NPC Character, VAR func AIState)
{
	return FALSE;
};

FUNC BOOL Npc_WasPlayerInMyRoom(VAR C_NPC Owner)
{
	return FALSE;
};

FUNC void Perc_SetRange(VAR int PerceptionId, VAR int Range)
{
};

FUNC void Print(VAR string Text)
{
};

FUNC void PrintDebug(VAR string Text)
{
};

FUNC void PrintDebugCh(VAR int Channel, VAR string Text)
{
};

FUNC void PrintDebugInst(VAR string Text)
{
};

FUNC void PrintDebugInstCh(VAR int Channel, VAR string Text)
{
};

FUNC BOOL PrintDialog(VAR int GameViewId, VAR string Text, VAR int PosX, VAR int PosY, VAR string Font, VAR int Seconds)
{
	return FALSE;
};

FUNC void PrintMulti(VAR string TextVariant1, VAR string TextVariant2, VAR string TextVariant3, VAR string TextVariant4, VAR string TextVariant5)
{
};

FUNC BOOL PrintScreen(VAR string Text, VAR int PosX, VAR int PosY, VAR string Font, VAR int Seconds)
/// \bug        The implementation removes an additional int from
///             the stack after retrieving the defined parameters.
{
	return FALSE;
};

FUNC void Rtn_Exchange(VAR string OldRoutineName, VAR string NewRoutineName)
{
};

FUNC void SetPercentDone(VAR int WorldProgress)
{
};

FUNC int Snd_GetDistToSource(VAR C_NPC Character)
{
	return 2147483647;
};

FUNC BOOL Snd_IsSourceItem(VAR C_NPC Character)
{
	return FALSE;
};

FUNC BOOL Snd_IsSourceNpc(VAR C_NPC Character)
{
	return FALSE;
};

FUNC void Snd_Play(VAR string Name)
{
};

FUNC void Snd_Play3d(VAR C_VOB Object, VAR string Name)
{
};

FUNC void TA(VAR C_NPC Character, VAR int StartHour, VAR int StopHour, VAR func Routine, VAR string WaypointName)
{
};

FUNC void TA_BeginOverlay(VAR C_NPC Character)
{
};

FUNC void TA_CS(VAR C_NPC Character, VAR string CsName, VAR string RoleName)
{
};

FUNC void TA_EndOverlay(VAR C_NPC Character)
{
};

FUNC void TA_Min(VAR C_NPC Character, VAR int BeginHour, VAR int BeginMinute, VAR int EndHour, VAR int EndMinute, VAR func Routine, VAR string WaypointName)
{
};

FUNC void TA_RemoveOverlay(VAR C_NPC Character)
{
};

FUNC void Tal_Configure(VAR int Talent, VAR int Relevance)
/// \bug        The implementation removes an additional C_NPC from the stack
///             and leaves an additional integer (Hlp_IsValidNpc) on the stack.
{
};

FUNC void Wld_AssignRoomToGuild(VAR string RoomName, VAR int Guild)
{
};

FUNC void Wld_AssignRoomToNpc(VAR string RoomName, VAR C_NPC Owner)
{
};

FUNC BOOL Wld_DetectItem(VAR C_NPC NonPlayer, VAR int ItemFlag)
{
	return FALSE;
};

FUNC BOOL Wld_DetectNpc(VAR C_NPC NonPlayer, VAR C_NPC_ID NpcId, VAR func AIState, VAR int Guild)
{
	return FALSE;
};

FUNC BOOL Wld_DetectNpcEx(VAR C_NPC NonPlayer, VAR C_NPC_ID NpcId, VAR func AIState, VAR int Guild, VAR BOOL DetectPlayer)
{
	return FALSE;
};

FUNC BOOL Wld_DetectPlayer(VAR C_NPC NonPlayer)
{
	return FALSE;
};

FUNC void Wld_ExchangeGuildAttitudes(VAR string TableName)
{
};

FUNC int Wld_GetDay()
{
	return 0;
};

FUNC int Wld_GetFormerPlayerPortalGuild()
{
	return -1;
};

FUNC C_NPC Wld_GetFormerPlayerPortalOwner()
{
	return NULL;
};

FUNC int Wld_GetGuildAttitude(VAR int Guild, VAR int TargetGuild)
{
	return ATT_NEUTRAL;
};

FUNC int Wld_GetMobState(VAR C_NPC Character, VAR string SchemeName)
{
	return -1;
};

FUNC int Wld_GetPlayerPortalGuild()
{
	return -1;
};

FUNC C_NPC Wld_GetPlayerPortalOwner()
{
	return NULL;
};

FUNC void Wld_InsertItem(VAR C_ITEM_ID ItemId, VAR string SpawnPoint)
{
};

FUNC void Wld_InsertNpc(VAR C_NPC_ID NpcId, VAR string SpawnPoint)
{
};

FUNC void Wld_InsertNpcAndRespawn(VAR C_NPC_ID NpcId, VAR string SpawnPoint, VAR int RespawnHours)
{
};

FUNC void Wld_InsertObject(VAR string MobVisualName, VAR string SpawnPoint)
{
};

FUNC BOOL Wld_IsFPAvailable(VAR C_NPC Character, VAR string NamePart)
/// \brief      Check if nearest spot is available.
/// \param      Character
///                 Reference to the character object.
/// \param      NamePart
///                 Substring that has to be present in the name of the spot
///                 (always converted to upper case).
/// \return     Returns TRUE if the nearest spot is available for the
///             \p Character.
/// \details    The function is searching for the nearest spot
///             (in a 14 meters bounding box) where the name of the spot
///             includes \p NamePart, that is available for the \p Character,
///             and that is in the free line of sight for the \p Character.
/// \note       If the \p Character is currently using the spot, the spot is
///             made available again for usage if the \p Character is currently
///             not inside a 1x2x1 meter bounding box of the spot.
/// \sa         AI_AlignToFP
/// \sa         AI_GotoFP
/// \sa         AI_GotoNextFP
/// \sa         Npc_IsOnFP
/// \sa         Wld_IsNextFPAvailable
{
	return FALSE;
};

FUNC BOOL Wld_IsMobAvailable(VAR C_NPC Character, VAR string SchemeName)
{
	return FALSE;
};

FUNC BOOL Wld_IsNextFPAvailable(VAR C_NPC Character, VAR string NamePart)
/// \brief      Check if any spot is available.
/// \param      Character
///                 Reference to the character object.
/// \param      NamePart
///                 Substring that has to be present in the name of the spot
///                 (always converted to upper case).
/// \return     Returns TRUE if any spot is available for the
///             \p Character.
/// \details    The function is searching for any spot
///             (in a 14 meters bounding box) where the name of the spot
///             includes \p NamePart, that is available and not in use by
///             the \p Character, and that is in the free line of sight
///             for the \p Character.
/// \note       If the \p Character is currently using the spot, the spot is
///             made available again for usage if the \p Character is currently
///             not inside a 1x2x1 meter bounding box of the spot.
/// \sa         AI_AlignToFP
/// \sa         AI_GotoFP
/// \sa         AI_GotoNextFP
/// \sa         Npc_IsOnFP
/// \sa         Wld_IsFPAvailable
{
	return FALSE;
};

FUNC BOOL Wld_IsTime(VAR int BeginHour, VAR int BeginMinute, VAR int EndHour, VAR int EndMinute)
{
	return FALSE;
};

FUNC void Wld_PlayEffect(VAR string VfxName, VAR C_VOB Origin, VAR C_VOB Target, VAR int EffectLevel, VAR int Damage, VAR int DamageType, VAR BOOL IsProjectile)
{
};

FUNC BOOL Wld_RemoveItem(VAR C_Item ItemObject)
{
	return FALSE;
};

FUNC void Wld_RemoveNpc(VAR C_NPC_ID NpcId)
{
};

FUNC void Wld_SendTrigger(VAR string ObjectName)
{
};

FUNC void Wld_SendUntrigger(VAR string ObjectName)
{
};

FUNC void Wld_SetGuildAttitude(VAR int Guild, VAR int Attitude, VAR int TargetGuild)
{
};

FUNC void Wld_SetMobRoutine(VAR int Hour, VAR int Minute, VAR string SchemeName, VAR int TargetState)
{
};

FUNC void Wld_SetObjectRoutine(VAR int Hour, VAR int Minute, VAR string ObjectName, VAR BOOL Trigger)
{
};

FUNC void Wld_SetTime(VAR int Hour, VAR int Minute)
{
};

FUNC void Wld_SpawnNpcRange(VAR C_NPC Evocator, VAR C_NPC_ID NpcId, VAR int Count, VAR float Range)
{
};

///
/// @}
///
