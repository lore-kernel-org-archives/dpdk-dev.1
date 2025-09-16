Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC3CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F27C4066A;
	Tue, 16 Sep 2025 15:54:37 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id A7AE540612
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:54:35 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-24458272c00so58398425ad.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758030874; x=1758635674; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K4zHIBx1fzlbTDNAefECitQuuCjknugEH4s50otYjGc=;
 b=Pl9N7pAkfMQW8+9kDiHkBcE7eijUKDllQLmyL+uo36C4v69Cd1UdN8kJhOlCEWjVmJ
 G58Rs5uo9T/kwvidztmuBtiG08dFC4PdueDc8AJcF/sEvylSXHre/MLNTDKF+Spg9OHj
 JAyq2IKZTI1CLb3G/923nqn2Ww7N1rS1slEwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030874; x=1758635674;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K4zHIBx1fzlbTDNAefECitQuuCjknugEH4s50otYjGc=;
 b=VFQ8hf29RkVh244JvgjZbwynx8mygLWiv/BK0+I4iQFVGHXVTDiNu9IbYFeg++PwWR
 z8S9kIC6AQLziju2wXTVshFKvKBpjqcFO2tmS4zW5JqifLICsseHwH/wm5oxyMQsxtJD
 /ckisDi5vFSQcHlyf3FCK6/MSItvA4QhhWWyA01Eo/n7HH62W45cSwulEBiVASXGlpXp
 WGzYgQHYFstFnyik3CgrEyr4KmCLcqBp7g1EH5uWi0kvChqtf2Rp5hgVq121Ya8gCkBn
 MiE2wrF/R8m4MC60Xd526usqJ8Y8jMlRn3cmmtrZ0j6Y1CQru3lCRWANT2ReNGhatEad
 JrMg==
X-Gm-Message-State: AOJu0Yy732KuWcJiIi1+9UX8MGt0fMxEu6CrNHDg2yJrVuJf4L2RFtU9
 HIKflH+eduEPKs1l2EZbiblvLmJimX/lvzzzVXMsWrWjULG95LAN17kDxpWhPna58p6d4rW61ga
 CnDZ9L0rNUgQRjJHfxndWZKQM80IMAFNgrTi7mBs0VIeijLIYg781s6U=
X-Gm-Gg: ASbGncsN4NVUBa1M27R2wRHoUqtWIeGfLcB39PDVj4TdPrrPPoXbDEijwV6rkLXbMs1
 cU9JXDpFHybVQBZAO8r/1hTUMUCSOw194Hzs1u7gJR9PgL7qtzfh7bhYbHReSV/p4PnULda86jr
 Nj21gwNHM6lRZPkALVJsydlO2Rxpd8oFjBb9jpc2Zqmv/6u2lzXqLHVoQegz9PjwW8MCQohoztX
 0kolUXa5Za4TeG0EXl5n1H/JrxSgwhC3trX+TKP
X-Google-Smtp-Source: AGHT+IGUYXXXZp0SutpZenVlwIF5rWTB71KefaAht4Ts7N/tT0O/DnGWuAclr9KjGrP3e1Y/Pr23MMePWAH18cOof1s=
X-Received: by 2002:a17:903:944:b0:267:16ec:390 with SMTP id
 d9443c01a7336-26716ec061emr100647215ad.17.1758030874411; Tue, 16 Sep 2025
 06:54:34 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:47:32 -0400
X-Gm-Features: AS18NWDgyplra9nLdyzpILCLjEUqL0dAQjBPi-iOSXOC1p9mNjlPqLJl8CJIRhc
Message-ID: <CAJvnSUD3ZvcuSb+iWbkfJKuJ9P_pe+gQS46pxV5Z6M42dBeAmA@mail.gmail.com>
Subject: DTS WG Meeting Minutes - September 11, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c61828063eeb753f"
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

--000000000000c61828063eeb753f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

####################################################################
September 11, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Andrew Bailey
* Paul Szczepanek

####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* DTS Videos: We have shared the DTS tutorial videos with Ben from Linux
Foundation / DPDK and he will cross post to their Youtube or other socials
   * Video 1: How to run DTS
   * Video 2: How to write a DTS testsuite

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* TG Driver Bind:
   * Andrew submitted a new version with a new =E2=80=9Cbound for kernel=E2=
=80=9D property
   * Patrick Robbto review and merge
* RSS:
   * Paul has submitted an updated version
   * Patrick Robb to test this and review/merge
* Mbuf fast release testcase / tx_offload:
   * Need to ensure that tx offload can only be applied to tx port/queue
instead of rx or tx.
   * Need to ensure we are correctly delineating between the queue and port
offloads config
* Virtio:
   * V1 is finished but Dean is sick so it won=E2=80=99t be sent until next=
 week
* DTS API:
   * Paul has sent the V1
   * Goal: every import for a testsuite is from the api dir
   * Patrick Robb to do a review
   * UNH guys should make a =E2=80=9Cdepends-on=E2=80=9D patch for this
      * Packet_capture imports cpu logical core list
      * We need to go through each testsuites and see what it imports and
see if it can be moved out
      * Let=E2=80=99s just make a spreadsheet with a row per import and col=
or code
by status, assign testsuites to people etc.
      * Patrick Robb to ticket this
      * Paul will handle artifact, and the parts inside a testsuite
* Single_core_fwd:
   * Now, in config func_traffic_generator does not include a TG path and
config path, since it is not needed, only perf_traffic_generator does
   * Now, context stores 2 traffic generators, which can be optionally a TG
or None based on whether they=E2=80=99re specified in the config
   * Trying to bind to the correct driver on TG at test_run state machine=
=E2=80=99s
testcasesetup:
      * Patrick will propose a couple ideas when he sends the next patch
      * One solution may be to gather the functional cases at runtime, run
those first, then run the perf cases second
* A couple patches have been merged:
   * Missing type hints
   * File artifact manager
* Default link topology series:
   * This breaks the DPDK build, and the UNH team needs to figure out why
* Updating docstrings:
https://patchwork.dpdk.org/project/dpdk/patch/20250910194259.1027220-2-paul=
.szczepanek@arm.com/
   * Patrick Robbshould merge this today before it goes out of date

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* A few more tickets have been pruned

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next meeting is Sep 25, 2025
* We should review the 25.11 release roadmap at the next meeting.

--000000000000c61828063eeb753f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
##########<br>September 11, 2025<br>Attendees<br>* Patrick Robb<br>* Luca V=
izzarro<br>* Andrew Bailey<br>* Paul Szczepanek<br><br>####################=
################################################<br>Minutes<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<b=
r>* DTS Videos: We have shared the DTS tutorial videos with Ben from Linux =
Foundation / DPDK and he will cross post to their Youtube or other socials<=
br>=C2=A0 =C2=A0* Video 1: How to run DTS<br>=C2=A0 =C2=A0* Video 2: How to=
 write a DTS testsuite<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* TG Driver Bind:<br>=
=C2=A0 =C2=A0* Andrew submitted a new version with a new =E2=80=9Cbound for=
 kernel=E2=80=9D property<br>=C2=A0 =C2=A0* Patrick Robbto review and merge=
<br>* RSS:<br>=C2=A0 =C2=A0* Paul has submitted an updated version<br>=C2=
=A0 =C2=A0* Patrick Robb to test this and review/merge<br>* Mbuf fast relea=
se testcase / tx_offload: =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0* Nee=
d to ensure that tx offload can only be applied to tx port/queue instead of=
 rx or tx.<br>=C2=A0 =C2=A0* Need to ensure we are correctly delineating be=
tween the queue and port offloads config<br>* Virtio:<br>=C2=A0 =C2=A0* V1 =
is finished but Dean is sick so it won=E2=80=99t be sent until next week<br=
>* DTS API:<br>=C2=A0 =C2=A0* Paul has sent the V1<br>=C2=A0 =C2=A0* Goal: =
every import for a testsuite is from the api dir<br>=C2=A0 =C2=A0* Patrick =
Robb to do a review<br>=C2=A0 =C2=A0* UNH guys should make a =E2=80=9Cdepen=
ds-on=E2=80=9D patch for this <br>=C2=A0 =C2=A0 =C2=A0 * Packet_capture imp=
orts cpu logical core list<br>=C2=A0 =C2=A0 =C2=A0 * We need to go through =
each testsuites and see what it imports and see if it can be moved out<br>=
=C2=A0 =C2=A0 =C2=A0 * Let=E2=80=99s just make a spreadsheet with a row per=
 import and color code by status, assign testsuites to people etc.<br>=C2=
=A0 =C2=A0 =C2=A0 * Patrick Robb to ticket this<br>=C2=A0 =C2=A0 =C2=A0 * P=
aul will handle artifact, and the parts inside a testsuite<br>* Single_core=
_fwd:<br>=C2=A0 =C2=A0* Now, in config func_traffic_generator does not incl=
ude a TG path and config path, since it is not needed, only perf_traffic_ge=
nerator does<br>=C2=A0 =C2=A0* Now, context stores 2 traffic generators, wh=
ich can be optionally a TG or None based on whether they=E2=80=99re specifi=
ed in the config<br>=C2=A0 =C2=A0* Trying to bind to the correct driver on =
TG at test_run state machine=E2=80=99s testcasesetup:<br>=C2=A0 =C2=A0 =C2=
=A0 * Patrick will propose a couple ideas when he sends the next patch<br>=
=C2=A0 =C2=A0 =C2=A0 * One solution may be to gather the functional cases a=
t runtime, run those first, then run the perf cases second<br>* A couple pa=
tches have been merged:<br>=C2=A0 =C2=A0* Missing type hints<br>=C2=A0 =C2=
=A0* File artifact manager<br>* Default link topology series:<br>=C2=A0 =C2=
=A0* This breaks the DPDK build, and the UNH team needs to figure out why<b=
r>* Updating docstrings: <a href=3D"https://patchwork.dpdk.org/project/dpdk=
/patch/20250910194259.1027220-2-paul.szczepanek@arm.com/">https://patchwork=
.dpdk.org/project/dpdk/patch/20250910194259.1027220-2-paul.szczepanek@arm.c=
om/</a><br>=C2=A0 =C2=A0* Patrick Robbshould merge this today before it goe=
s out of date<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* A few more tickets have bee=
n pruned<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>Any other business<br>* Next meeting is Sep 25, 2025<br>* We should rev=
iew the 25.11 release roadmap at the next meeting.</div>

--000000000000c61828063eeb753f--
