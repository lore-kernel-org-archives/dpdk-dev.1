Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C505CCFA03
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 03:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9BBB402D4;
	Tue,  4 Nov 2025 04:35:23 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 313E7402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 04:35:22 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-295df6ad56cso11239055ad.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 19:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762227321; x=1762832121; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JRTysSXygq6LAjfZlqnMmQEd7ec/KyCN2yKwkwmO4YE=;
 b=hk4oFOuzLWzCaQWgyQ0jvqm7ZIJnU+ivM1wfIjmfvvwUoEqRdYM+SazE+vNkiGmbFk
 JL9cFD9jZrOppXik32tERBO26cTF8K8GjMRIdmgFzmXZmtqmXNDYBHeXKz0Y/PjnLjTF
 pYrvQl+DlDIxXWA3GUss+iqzAZCRnYos113mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762227321; x=1762832121;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRTysSXygq6LAjfZlqnMmQEd7ec/KyCN2yKwkwmO4YE=;
 b=DCArq6ZHqaWIxvF5hSOazFRr4XwYxI9P5dGJacrOzhdwKfbh9t9jnn4gnBijRTOIv/
 ztOF/wMnPVKiX/6+V4w85cWN6VYmJjWyVWeiaBAHI/BYaw7fODseFCF84T20HrLO9l1P
 7q5r7K7gsitb5jKIBC6GwCuYB1yBVAKUFYYhndmdKWAYgQ1Z5YQqvKxttoxNzlXbyzdd
 jecmyytdMOq05nLG9Pjtx8+E9S2kYeyGhD+Fhd58FnRRlHZM0wxdGmOS/MjWtZSEBsH2
 uQ0sBwsXJBFvYsltSpsoNh3Ri8wJlDNWWbpDfzPvjM/HilUDCLYLyrTVVHw1TfRYEgol
 2aew==
X-Gm-Message-State: AOJu0YxUztCaOrBbhNTa8oQq0ILOdguK+kg8BeNi8sO8+O1yDusJv7dX
 28Q/DEkWTl08UP8JD89qylN8vqIVvTduYCQv/+SLI0QHioXqe93wCra85Rox6UUi/KZXozU9JEP
 BtYgUTEEB6OkO0A8sQ4z2t3HtVWdqGp7NNZMq0L8y7ufaWsm2qKmsPRU=
X-Gm-Gg: ASbGncvvPfXPFNUjM3DYz0suN0/diNijGGtCaRGZE+cgyGVQD7HGKBBkB9oza3x+EAt
 aXc39w01uDiQymQHnWwxLG+dfB03nmZvebZLs3sxpO/l7NBal427M+1QRHLkwAI1heqi8bZ1Xoq
 B5hYIfMLs43jN5K24Ns+Sy27pFFSolXrohgrpeGDPFODOVcGMVV6svVs63075/pcofvFTM4nZ+6
 dFFVJkLmgr/ZYo3XH8YGM8uSS8N0V7jX6A5QzyS1n4ofRfj8k5jtxPvzsRfzbC5vjFpjQAT6+xt
 AeycKVV4bDI=
X-Google-Smtp-Source: AGHT+IHHrpFs0jh2FvJvCZA7bKuC6z1M8zDvT3qD3vRIcTsj8VRE5XI9lmYnuOTjLeDQd8XvqhV8pEwZb2Arovox8S4=
X-Received: by 2002:a17:902:e882:b0:295:9b73:b161 with SMTP id
 d9443c01a7336-2959b73b297mr91582735ad.44.1762227320725; Mon, 03 Nov 2025
 19:35:20 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 3 Nov 2025 22:34:14 -0500
X-Gm-Features: AWmQ_bkCYCJlSpQtYHJA9ta13CNBEVL-OFARzVkvVCJz431ZqxSlggRhCRudQhU
Message-ID: <CAJvnSUCgBnw=wXi-1ugP_RYZYMBC2xY2VGBBxv0_WEuekiLYAQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - October 9, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000077339d0642bc850f"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--00000000000077339d0642bc850f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

####################################################################
October 9, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey

####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* RSS Testsuite:
   * Patrick to review
* Mbuf fast release testcase / tx_offload:
   * Looks good overall
   * Most likely the testcase will need to be updated to reflect the latest
tech board decision on mbuf fast free (it is now enabled by default instead
of disabled by default)
* Virtio:
   * V2 looks good to Patrick. When it is final - send to Maxime (virtio
maintainer) for his review
* Single_core_fwd_perf:
   * Patrick is going to send a V5 which adds a performance_metrics.json
   * Traffic Generators are setup and torn down as needed. As a part of
this, Patrick flattened the shell pool system so that there are no longer
testsuite and testcase level shell pools, but this removes some safety (it
stops protecting us from rogue shells which didn=E2=80=99t get closed
      * Can we add a flag (like persist) that allows a shell to be added
without being added to the shell pool? Need to ensure this is cleaned up in
testrunteardown
* Move testsuite methods to API modules
   * Patrick to do a review

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Roadmap status review:
   *
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWt=
xnko/edit?tab=3Dt.0
* Next meeting is Oct 23, 2025

--00000000000077339d0642bc850f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">#########################################=
###########################<br>October 9, 2025<br>Attendees<br>* Patrick Ro=
bb<br>* Luca Vizzarro<br>* Andrew Bailey<br><br>###########################=
#########################################<br>Minutes<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* None<=
br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch=
 discussions<br>* RSS Testsuite:<br>=C2=A0 =C2=A0* Patrick to review<br>* M=
buf fast release testcase / tx_offload: =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=
=A0 =C2=A0* Looks good overall<br>=C2=A0 =C2=A0* Most likely the testcase w=
ill need to be updated to reflect the latest tech board decision on mbuf fa=
st free (it is now enabled by default instead of disabled by default)<br>* =
Virtio:<br>=C2=A0 =C2=A0* V2 looks good to Patrick. When it is final - send=
 to Maxime (virtio maintainer) for his review<br>* Single_core_fwd_perf:<br=
>=C2=A0 =C2=A0* Patrick is going to send a V5 which adds a performance_metr=
ics.json<br>=C2=A0 =C2=A0* Traffic Generators are setup and torn down as ne=
eded. As a part of this, Patrick flattened the shell pool system so that th=
ere are no longer testsuite and testcase level shell pools, but this remove=
s some safety (it stops protecting us from rogue shells which didn=E2=80=99=
t get closed <br>=C2=A0 =C2=A0 =C2=A0 * Can we add a flag (like persist) th=
at allows a shell to be added without being added to the shell pool? Need t=
o ensure this is cleaned up in testrunteardown<br>* Move testsuite methods =
to API modules<br>=C2=A0 =C2=A0* Patrick to do a review<br>=C2=A0 =C2=A0<br=
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla di=
scussions<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>Any other business<br>* Roadmap status review:<br>=C2=A0 =C2=
=A0* <a href=3D"https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa=
_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0" target=3D"_blank">https://docs.google.=
com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0<=
/a><br>* Next meeting is Oct 23, 2025</div>
</div>

--00000000000077339d0642bc850f--
