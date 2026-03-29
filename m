Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C3210D1487
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 00:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB8C402C3;
	Sun, 29 Mar 2026 01:38:53 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id D0BBD400D6
 for <dev@dpdk.org>; Sun, 29 Mar 2026 01:38:52 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso19320a91.0
 for <dev@dpdk.org>; Sat, 28 Mar 2026 17:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774744732;
 x=1775349532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5kJXNNhRMUuqkCBy0Gu4ZA/Ya9udpekUwUsCEUlIC8=;
 b=LblW2q5hrQ1Vu8i7KBDayICt3AHufgXMl699ZyPoZCmxMWDxOwEjPWhKJxV1quCCzo
 ojIEjHEiW+sQDoJSlSD0lQZ1xL+7aGuNRPu8TILusi65bqF6vFAOtA4fk6NN7wzHYJp/
 3zbSRAwVTUKeFZM4GUjd5IzgqeFt9qUJ3oAGT77f6EH0V8W4Q3/54IMyr7z2Gx6a5DgP
 s8qGdYoJicuiH01o79mW2G3UJ584WlvTll7anuq94ixGfTgBDpL53ZrcWCgXWmjp90w4
 KBsLwp0L2XeTNmdKdsuN7OJrZ7L3o7mD6xXi8Un09YQe9x7T/eb8kYLrjBanSvBnckzF
 7i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774744732; x=1775349532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M5kJXNNhRMUuqkCBy0Gu4ZA/Ya9udpekUwUsCEUlIC8=;
 b=rLMV8GHSLk/dOxmZzNXZGroPBInKg+6AUy2oOT649wiZJk7MwY1ay50KfCtNRM4WxV
 g1TH6CD0MQC2dRw3WNGUBzvEWl2uwyeNsh2XaT8bmLLNbt1ebxb1lENnExP3jIwZF4Ek
 32jjrAgdbmEwr8mzZryK/0JLXZPcYOG1VmvMJJq4rutREwogjg7eO7cinA8LdvW+/J3y
 TwTlJVqMleptfXuS3C4tW+Vq4HLhlPgM+DSiT/5JbTpLccyZfjxPIwR3atAfA3y+fyVT
 CynGMwG6b8ULFYbAJF7uSbBpFaaDzBbzIQJCT4Z1F27uwuL6+jgy+Ng8hPNxh71jUing
 II1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQYRlW9NGIeN7xT6QPJAbH0ySZv/BPCXcujTwf65tcfAW8anm6KdFLiNM3cG7pzVjxSs=@dpdk.org
X-Gm-Message-State: AOJu0YwLQJ2TBLYkGqaS9XrWCbxf4pje1MVSZ7t6htLI8+jlCSc78/Xd
 6XttjvBi8oFwQmeT/hdLfhopwU1fq2zHmpwcd2VAWIuuFeDZofMBiZ/jOl74f0EkMCU=
X-Gm-Gg: ATEYQzxgbb0lF8TVyur4vmDy414Zzh7mqzRO7DgRcoPuET0CiJ0x+QpNBZIHTsNGiXp
 CHWUwre8zZgZTLpmi03jMFn+63eK1ZKjji2HL1tlPFQcjIo328DTs7NcvXHhSfJLfy6/0WKgX73
 0ciF9sj3NKpjg1KUaX8ho3fk/BogtlJDBYNKsJZ8d/1r4KOck8sN++0WfjD4tUgnQa1+cXIvOYd
 2j64DBETEDjyGlpg12CIgzQpYf0znyxfbcq+XzElsVM1zyKo13JMpW7GKRtm+i6ZyOXQPkGyuYf
 izAOJsCTp4BbmJpqSj7WFbizS5siMnv9bHEX2HXgMvr+2AZLOgvXcIkRI+sXWsm6Qi58gZyNk1w
 E0GsQywAPBFHoG7AVvxJE6eeLtNFKRf0YYFiYxIaAmGJz4eWavjYQC/LVmNSXhinN8zktyzx82w
 ifuG/S6bBKvdU2rP3xgbTBehxMcZpDZsBWVW4=
X-Received: by 2002:a17:90b:4b09:b0:35b:e56e:b5a6 with SMTP id
 98e67ed59e1d1-35c2ff2676dmr6751291a91.1.1774744731685; 
 Sat, 28 Mar 2026 17:38:51 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916ba75esm2662211a12.6.2026.03.28.17.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 17:38:51 -0700 (PDT)
Date: Sat, 28 Mar 2026 17:38:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: <david.hunt@intel.com>, <anatoly.burakov@intel.com>,
 <jerinj@marvell.com>, <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH] power/amd_uncore: add e-smi installation instructions
Message-ID: <20260328173841.32b53918@phoenix.local>
In-Reply-To: <20241129043207.999912-1-sivaprasad.tummala@amd.com>
References: <20231219032826.4814-1-sivaprasad.tummala@amd.com>
 <20241129043207.999912-1-sivaprasad.tummala@amd.com>
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

On Fri, 29 Nov 2024 04:32:07 +0000
Sivaprasad Tummala <sivaprasad.tummala@amd.com> wrote:

> Added section for installing and building the E-SMI library
> for AMD EPYC Uncore support and version requirements.
>=20
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

A lot has changed since this patch was originally submitted, and
apologies for the long delay in getting back to it. The E-SMI library
is in much better shape now =E2=80=94 it's packaged in Fedora and EPEL, v4.=
2+
bundles the amd_hsmp.h header that was causing build failures, and
upstream now has pkg-config support.=20

Please revise the patch (and the meson.build) to match current E-SMI upstre=
am.
The dependency check should use dependency('e_smi', required: false) via pk=
g-config
rather than the bare cc.find_library() that's there now.
The current ESMI_header variable in the build file is defined but never tes=
ted =E2=80=94
that should be cleaned up too.=20

For the documentation, just state the minimum E-SMI version required and li=
nk to
the upstream project. No need to reproduce build instructions; that's the u=
pstream project's
job, and distro packages make it even easier.

It would be great to get this updated in time for the 26.11 LTS release.
