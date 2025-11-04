Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B84CCFA03
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 03:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7035402D4;
	Tue,  4 Nov 2025 04:35:54 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4319B40299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 04:35:53 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2953ad5517dso35681915ad.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 19:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762227352; x=1762832152; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b4ofacUd3oUVnVBaeeDBHwFnGvXWEN2yiG/aYV5I/v4=;
 b=AjUdiJo/eTpLuRwEv5EpXYmQB0O8B2EtFDAqkzimgrbQxQImCQ8usb+8jxqJHHitST
 jLotCBOMsp8VF8KIzMR6NpnvEyl2HQLu4au6xFNWF0FGbIF6a1Cmc9UVlk5UBTMoebLv
 L5FVrnKXQN8w2GpxMhIBVQtCl1PFjaqOtCfgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762227352; x=1762832152;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b4ofacUd3oUVnVBaeeDBHwFnGvXWEN2yiG/aYV5I/v4=;
 b=dMWyxxoVkzwyoYwl3em2RXPtjKLF4ZwJSUPm0mE8Q2oJPjx/9uci3lCb/CxhuakNSA
 O5zUWeLnPM0MrRkiRt5t8sIbPI9klOjOZ8B1o3CZCNn/rRwRgWI5QAe8mjYvprsIk51K
 eKafCDG7QWsbs1bs6xKqyo2djpKaV7fMKLZMU5Z/cos0RnIdzRURYaeyikjWinDk0RN4
 jbecgAjF+TI9LAYDFmWnQaUVJDStlyGz5ZnQgNxtgC35FylneM0SVud/eNxndvcW0ZiY
 7mJcwsnIX5g2DlzM6iFQQyZRAZPj303k0AJ6BCuNelEFYRvXYWjJfmxT50kwBeZF5Yh8
 PSCQ==
X-Gm-Message-State: AOJu0YxGXg9Q9QIUtIxIZlbIUlrxylF4aAbEO5aLgb7X0m9QXfAMh4qn
 DLjKQVRS3JRG+qBkKt+zHoMcxOmr4jW1YjkfjIp9nFHN3yeQBoA0wRlsRO17hD+XvqMyi2vT6s9
 IPtQ6nSFYeaSNiISrKSfJfVpBhfK/9/QIlGEUrHabVPAWLzka9eq2e5Q=
X-Gm-Gg: ASbGncs/9h0z+imDOrhFHTWNDzqzZSJvVaSimE+iZJHi4HVD91izE7usNYMXYlLra1Q
 jvQAHD16uSmO4ewvjDHo8Jb5prU+6Xt2Gl1Xa5pdwBtrif1c0l3nRFKNiKLhwaDzax/uvqv/aZg
 cqyR6Zjg+RQXYhF9Hu4IK0FA2kShA1yBA2jcQOiTuZu+8pgel8VWgLgI6lzu+DvIAAFqeeRQexS
 yryR0IfAw7U22sh40Fbn0bPbfdHWIgkq26H3ujZsQly5wosKbXq8fMepiIww3bl+Vd/x1gwRNcW
X-Google-Smtp-Source: AGHT+IHjasDymb9y5/3qHWYvUM8gmCT3SRUL72CrE5/lGCnEfQvLSaGEMsGW8QXzKusV5Pf9bbD2WtRVwKdVwcnnZdQ=
X-Received: by 2002:a17:902:ce83:b0:295:2cb6:f4a2 with SMTP id
 d9443c01a7336-2952cb6f633mr165904375ad.55.1762227351974; Mon, 03 Nov 2025
 19:35:51 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 3 Nov 2025 22:34:46 -0500
X-Gm-Features: AWmQ_bkjiPaih6nod0-z1pjZNIJgXOFW2HNmSYT2YQ5hZaOKOQJt6eiW1GwUcM8
Message-ID: <CAJvnSUAa5BOVM+X9iLssQxXZ2w-hjtY1nZAM+3y8Dv0+6CCuYA@mail.gmail.com>
Subject: DTS WG Meeting Minutes - October 23, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005404290642bc87ba"
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

--0000000000005404290642bc87ba
Content-Type: text/plain; charset="UTF-8"

####################################################################
October 23, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey
* Paul Szczepanek
* Indira

####################################################################
Minutes

=====================================================================
General Discussion
* RC1 is about to release

=====================================================================
Patch discussions
* Mbuf fast release testcase / tx_offload:
   * Rebased this morning
   * Patrick to give it a testrun and merge today
   * Cover letter is missing but we can still review and merge
* Virtio:
   * Dean working on a couple comments from Luca and Patrick and will send
a v3
* Single_core_fwd_perf:
   * Patrick sent the v5
   * The changes are:
      * 1. Adds a new api/test function for writing a
performance_metrics.json file within output/{current_testsuite}
      * 2. Adds a new option to create a new interactive shell without
adding it to the current shell pool, which allows it to persist beyond the
current stage in the testrun.
* API test.py and packet.py:
   * Includes test and packet functions for testsuites
   * Merged by Luca
   * Everyone needs to rebase their testsuites now that this has been
applied, and use the new verify etc.
* RSS:
   * Patrick to do a review
* dts: add steps and verify sections to docstrings
   * Most likely a duplicate, Patrick can mark as rejected after confirming

=====================================================================
Bugzilla discussions
* None

=====================================================================
Any other business
* Roadmap status review:
   *
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=t.0
* Next meeting is Nov 6, 2025

--0000000000005404290642bc87ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">#########################################=
###########################<br>October 23, 2025<br>Attendees<br>* Patrick R=
obb<br>* Luca Vizzarro<br>* Andrew Bailey<br>* Paul Szczepanek<br>* Indira<=
br><br>####################################################################=
<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>General Discussion<br>* RC1 is about to release<br><br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Mbu=
f fast release testcase / tx_offload: =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0=
 =C2=A0* Rebased this morning<br>=C2=A0 =C2=A0* Patrick to give it a testru=
n and merge today<br>=C2=A0 =C2=A0* Cover letter is missing but we can stil=
l review and merge<br>* Virtio:<br>=C2=A0 =C2=A0* Dean working on a couple =
comments from Luca and Patrick and will send a v3<br>* Single_core_fwd_perf=
:<br>=C2=A0 =C2=A0* Patrick sent the v5<br>=C2=A0 =C2=A0* The changes are:<=
br>=C2=A0 =C2=A0 =C2=A0 * 1. Adds a new api/test function for writing a per=
formance_metrics.json file within output/{current_testsuite}<br>=C2=A0 =C2=
=A0 =C2=A0 * 2. Adds a new option to create a new interactive shell without=
 adding it to the current shell pool, which allows it to persist beyond the=
 current stage in the testrun.<br>* API test.py and packet.py:<br>=C2=A0 =
=C2=A0* Includes test and packet functions for testsuites<br>=C2=A0 =C2=A0*=
 Merged by Luca<br>=C2=A0 =C2=A0* Everyone needs to rebase their testsuites=
 now that this has been applied, and use the new verify etc.<br>* RSS:<br>=
=C2=A0 =C2=A0* Patrick to do a review<br>* dts: add steps and verify sectio=
ns to docstrings<br>=C2=A0 =C2=A0* Most likely a duplicate, Patrick can mar=
k as rejected after confirming<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* None<br><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other busi=
ness<br>* Roadmap status review:<br>=C2=A0 =C2=A0* <a href=3D"https://docs.=
google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=
=3Dt.0" target=3D"_blank">https://docs.google.com/document/d/1doTZOOpkv4D5P=
2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0</a><br>* Next meeting is Nov =
6, 2025</div>
</div>

--0000000000005404290642bc87ba--
