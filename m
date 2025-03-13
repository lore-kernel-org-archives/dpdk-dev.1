Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDB2C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:22:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CE7402D9;
	Fri, 14 Mar 2025 00:22:22 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id F186840269
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:22:21 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso3213381a91.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741908140; x=1742512940; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wmoCBNAr0ciQMH/4kWQU3vc437VDsuhd7QrV+u/HI6I=;
 b=TjNXUfP/1gqRVfBEXHaRGPZZ+PE4diKG7q8NvPeF7BA29JFhW4HBvf897bDkA8IAHZ
 AF/fzZK6tzIG51i+qf29ikRwpd46zOvHFlIfK6K/TUZA/7XFd9ix21JtytddXIZb2MQO
 ivzj3rrsesuZQrINOWI9+fxip45sE+QGXw6Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741908140; x=1742512940;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wmoCBNAr0ciQMH/4kWQU3vc437VDsuhd7QrV+u/HI6I=;
 b=ReyunnIUOHZs5Lh0l8Qj6rz1LGHaHc7mgAO+QLX2t+KTrTgvtXNipRq4qv5+t6bDKU
 YSRNUQDy0b2DsiyatDK/1T7sast7jNR6K2xV9hvy0mQqNZ5OaV4Lza4GzuCAFoM5DlKj
 Z0+IcOSVaDq3f1SPy7sdgf9qHPM5Ul0/mU1da68AxI+Ok/bNGbQ1a1NyqwiYy42ms7xQ
 ++ObJrhlffNxgFKY/RuSV4qG6Z04JPILvCrFKyXx5rDpt8MkmKGBv7SYQHHy2gFBG4zl
 9GHKrrJzPBc21NG7JObximd//+ZfDmaZ80LGBoOg3qsT408X+qNwtZwP0uzHJaWHEhGE
 5deg==
X-Gm-Message-State: AOJu0YwFuEcpX6/EAnb4VP2zNK5a3/4s9zwJhIO+hLjUvy0SrGvE7qcz
 11FXT5G8ZSFtj9a78xYoy5OSasv5m/87J6aanFuG0/6YCLt0o24/VcMqfQQ4Q4hoWRE0CBJwoQJ
 /m6RZ5jq2eWhDurkKYzCtyTZdxtZsrAwJHO91XrBt1jrJGAgjR9y5Dw==
X-Gm-Gg: ASbGnctKGEvmUQY7sn+g44gOp8g+yiwy9dKR9BsKBHtH0giSa/9wdH7Pj6PWvqfGT0D
 dho7k3uT9VRONnZPdTgRRSkHbw1Rz+JJrPPSZssmJsr3qOEng/FMdsR8wDBZDtS4By0zi/n/NAx
 w3Rf54Rpi3+4T4x5XNh2QEve639q61LwyREEAlbUcmRQibfubiwyoT29zuxDM=
X-Google-Smtp-Source: AGHT+IFrbDtK5HJwvIQoYxeoMKxeM8GZ8Wgy1EvZvdkzL4hQ/1wGk+Xta3OmMjXtgJUv3oZsvREx1bbVmSLmYqMrNp0=
X-Received: by 2002:a17:90b:2cc8:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-30151cad1bamr395911a91.5.1741908140442; Thu, 13 Mar 2025
 16:22:20 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:18:37 -0400
X-Gm-Features: AQ5f1Jp2uS2e8JYXiZUsxgaspxneraXJf4HI3pQqq53f_G-s1wt39D3oBhiWbA8
Message-ID: <CAJvnSUDbu_h1K=6e=vQys=v9M7MEKoa+Q63ydQv=AEi3jZ5JXg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - February 13, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f15f9a06304197b0"
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

--000000000000f15f9a06304197b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
February 13, 2025
Attendees
* Patrick Robb
* Paul Szczepanek

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* UNH has started publishing results from in repo DTS to lab.dpdk.org as of
yesterday
   * Just running mac_filter now, but will add more testsuites and devices
soon
* TestPMD Verbose output: Last year there were two patches submitted (but
not accepted) pertaining to adding new verbose levels to TestPMD
   * Patch:
https://patchwork.dpdk.org/project/dpdk/patch/20240802195824.1336603-5-step=
hen@networkplumber.org/
   * One would add a verbosity layer 4 which would print 1 line per packet
in tshark format
   * One would add a verbosity layer 5 which would provide a hex dump of
the packet
   * These options above were of interest to us for matching packets, and
gathering more info via testpmd for certain testsuites
   * At that time, Alex was looking for an addition to the patch which
would include RSS hash and RSS queue info
   * Today, Dean from UNH is running into a similar need for his
checksum_offload testsuite, which he wants to update in order to match
based on the payload (via the hexdump option). So, Dean is reviewing this
old series and may see if he can start a conversation with Stephen (the
original submitter) on it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Sut cleanup:
   * Missing a type hint - Dean will submit a new version
* Reviews for the topology patch are critical so that we can merge this
soon and avoid having to update it
* Remaining patches:
   * Majority are old patches from Jeremy which Patrick needs to rebase,
test, update if needed, and apply. Most of the testsuites should run fine
more or less as is. The framework updates (like VF support) might be a
heavier lift.
* Ethertype:
   * Nick will toggle back to this once he=E2=80=99s done with reviewing Lu=
ca=E2=80=99s
topology patch (today). His capability check based on setting a standard
TPID is working, so he should be unblocked.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next meeting is Feb 27, 2025

--000000000000f15f9a06304197b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>February 13, 2025<br>Attendees<br>* Patrick Robb<br>* Paul S=
zczepanek<br><br>##########################################################=
###########<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>General Discussion<br>* UNH has started publishing results =
from in repo DTS to <a href=3D"http://lab.dpdk.org">lab.dpdk.org</a> as of =
yesterday<br>=C2=A0 =C2=A0* Just running mac_filter now, but will add more =
testsuites and devices soon<br>* TestPMD Verbose output: Last year there we=
re two patches submitted (but not accepted) pertaining to adding new verbos=
e levels to TestPMD <br>=C2=A0 =C2=A0* Patch: <a href=3D"https://patchwork.=
dpdk.org/project/dpdk/patch/20240802195824.1336603-5-stephen@networkplumber=
.org/">https://patchwork.dpdk.org/project/dpdk/patch/20240802195824.1336603=
-5-stephen@networkplumber.org/</a><br>=C2=A0 =C2=A0* One would add a verbos=
ity layer 4 which would print 1 line per packet in tshark format<br>=C2=A0 =
=C2=A0* One would add a verbosity layer 5 which would provide a hex dump of=
 the packet<br>=C2=A0 =C2=A0* These options above were of interest to us fo=
r matching packets, and gathering more info via testpmd for certain testsui=
tes<br>=C2=A0 =C2=A0* At that time, Alex was looking for an addition to the=
 patch which would include RSS hash and RSS queue info<br>=C2=A0 =C2=A0* To=
day, Dean from UNH is running into a similar need for his checksum_offload =
testsuite, which he wants to update in order to match based on the payload =
(via the hexdump option). So, Dean is reviewing this old series and may see=
 if he can start a conversation with Stephen (the original submitter) on it=
. <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Pa=
tch discussions<br>* Sut cleanup:<br>=C2=A0 =C2=A0* Missing a type hint - D=
ean will submit a new version<br>* Reviews for the topology patch are criti=
cal so that we can merge this soon and avoid having to update it<br>* Remai=
ning patches:<br>=C2=A0 =C2=A0* Majority are old patches from Jeremy which =
Patrick needs to rebase, test, update if needed, and apply. Most of the tes=
tsuites should run fine more or less as is. The framework updates (like VF =
support) might be a heavier lift.<br>* Ethertype:<br>=C2=A0 =C2=A0* Nick wi=
ll toggle back to this once he=E2=80=99s done with reviewing Luca=E2=80=99s=
 topology patch (today). His capability check based on setting a standard T=
PID is working, so he should be unblocked.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* None<br><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other busi=
ness<br>* Next meeting is Feb 27, 2025</div>

--000000000000f15f9a06304197b0--
