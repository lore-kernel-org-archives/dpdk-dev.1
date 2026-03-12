Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51665106ACE7
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3792D402AC;
	Thu, 12 Mar 2026 21:10:44 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 5959140275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:10:43 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d1872504cbso1612908a34.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773346242;
 x=1773951042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUj9d5zYXKMHo5UBZUI1I7FY0ASYrfGIYhft9Ge8IYk=;
 b=JW066uUNudCX5T7OJ5Ta8E9x35GgjexljWgQo898YEw4+l7abOQkn5AXQ1HR1bZu3c
 tIannLAaxCmjrAutN/q+NygLPk1ui8O+/oKUlncJKEKNvSuunvV9BGvbRfeZtT82lpS/
 02uheuF1Ic5tj8EI4QRtAYXfgiBz30SVkqDDuntIEouG7lxOfKco6qKO7cFiOpu+oaU6
 F0HV1jqQ9nJAlH+1i7wRUEOCA/X5RYr2e5UCcYy1r0qiwib2Xg1xpERDgu7xtZeXmttK
 raN0KJxkbAVGYbruiDPCJehWVu8AgOTiBJjbtDjdeDvCaEvWP22Np2yCVJ9f8J1BgFvv
 AdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773346242; x=1773951042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUj9d5zYXKMHo5UBZUI1I7FY0ASYrfGIYhft9Ge8IYk=;
 b=GafBzKpMujya2h1lqSb0AgyxqDt841t24gtYf9vupgd/U4T/mYDf1OFRVIJs1HTW5b
 EEoX+jZKbTzned1pkXef/2DoKy1xTAjZBbcqpsXVvh0tLNvjwb+Ss9rzTApnrAud5qLW
 SqyMijasjcRMeV6UBWTxkYz/fhMDKccmGGz87Ssa76YQk2sDQVWSBe3TbIXkBL/ADMa3
 euzECOrOO0lriiDirBchVCi1WEd/ibHvrY6lOZ4P3X09rRF9a3yAwglenlSQmcjWHZVy
 c6IK1EeNu6Kf9s6g0iMia/pu2LakhzVQ+FimjDEGDAjG6mjBQ2cXWhM8JO+IUWd/d0RD
 Ix+Q==
X-Gm-Message-State: AOJu0Yx3u2oh/ngHv/jgNtVpaA1Ue97V+FK6gXdDY1pAhmgHxK+RSpNL
 CGZqp9zrs16Hqo3AFMc55wcaR1meymBp1Y+hlbqopQR6zrX5WcKNlBqg4E0X9dBKRHTCU2bQkTZ
 RTvb8
X-Gm-Gg: ATEYQzzuhm6trAX2nxgwEqpLV+albNXPUMIjZ1Y3NSOIjs1OsdvY77oolb+L1fmYNpd
 THQOJRgUh+D7jy4JUDmSOrm30RVProhze9D5O7YbdaYYWmbEQmg0nKOrRPb7Rkx+laUfB32sIj4
 wN3o8Ti7LLQumWkKkeRIuI91m1tXRoR0ig4t3mOE0ReFnxOEiV3xoroqJ7iuoTVgXtqkgz7xLe/
 KiYaZA1NExms/Qpwv0cWx0KdszYTUVsi5dWJ4fZlym0xo4BFskyPZqZop5wyiW0Ze8yk9vcBYMo
 vHeMaDCbr4mIqcRz1SF+cePdYYgg9gIwBbgdl3USFz6MgNHSltkJHfoIw87F14+aOH+hugIJiAq
 GuLb/+My9FRXjCHNhS/ruiiyt3t0P9Jj71pB4JqBjxkp7BsblSqKgcc9siuZtPaB25UlSPkB/CF
 Tk05Ju/Ezy/1d271vd3dj13/nS3u52zNqX4R4=
X-Received: by 2002:a05:6830:1041:b0:7d7:3ed3:cc8d with SMTP id
 46e09a7af769-7d776b844f6mr2135489a34.6.1773346242370; 
 Thu, 12 Mar 2026 13:10:42 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac3230fsm4681015a34.4.2026.03.12.13.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:10:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:10:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: add Co-developed-by to commit log check
Message-ID: <20260312131039.6ec4ddf3@phoenix.local>
In-Reply-To: <23032153.EfDdHjke4D@thomas>
References: <20260312185403.1051832-1-stephen@networkplumber.org>
 <23032153.EfDdHjke4D@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Mar 2026 19:56:25 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 12/03/2026 19:54, Stephen Hemminger:
> > Add Co-developed-by to the recognized tag pattern and tag
> > sequence order in check-git-log.sh. =20
>=20
> Why using such tag? Signed-off-by is not enough?
>=20
>=20

The tags were inherited from the kernel development process.
=EF=BF=BC
Signed-off-by is the DCO (Developer Certificate of Origin) attestation.=20
It says "I certify that I have the right to submit this code under the proj=
ect's license.

Co-developed-by explicitly marks someone as a co-author of the patch.=20
Without it, there's only one author recorded in the git metadata.

I just wanted check-git-log.sh to be quiet if it was used.

The Co-developed-by is new, and probably came about because some people
need/want to have their contributions recorded in the git statistics.
Silly corporate overlords count contributions and it matters to them...

PS: If DPDK was exactly following the kernel process, every time a patch wa=
s merged into a sub-tree
it would get a Signed-off-by from a maintainer. Because the maintainer is v=
alidating that
the submitter had the correct rights.
