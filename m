Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB62C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 08:59:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3254D4042E;
	Wed,  4 Jun 2025 10:59:27 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 878324029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 10:59:25 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7caeeef95d4so626864085a.2
 for <dev@dpdk.org>; Wed, 04 Jun 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749027565; x=1749632365; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Yb95dAhS23G+MJ53qtkdgMjIjVziyGFacgJj6OLapo=;
 b=HL1RNLCxeR2YxhPJbzxCZtiCerSsVS+Fjyb4EAISytBGeogw+UQj4/P5hpPuWl14To
 GDqYtrxvszsXa1bHxAYJJHfbDqowAbaeIw58Jg0nfJx97gv7uSbpb3IuRpfZCYYpNyRN
 ew6Qbriro80QVgaitFqOUSUQ5litquqbJnymXbifv6pKhhZhFDCk27Mf9H6/R4y2KGoK
 IwhIKbGz0hfwQAiYhyRt2gYFBOQ+JIiVal9EVoXtj47bSFFsD10K81usFV2fh3Jn/7Ob
 dKBEcyHPUWONWvOETxSKE8VYgyvNUYLXvaIezfFi/MeFhfYpyBHYmNM586jbYYc82WDK
 lvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749027565; x=1749632365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Yb95dAhS23G+MJ53qtkdgMjIjVziyGFacgJj6OLapo=;
 b=qs2t+bF1SmHcAZwpvKWjuMrrZ/F3N0lk0svAzJ47Nv8VhCNbHBU+SIKtu4QP6+kCds
 eY76qhytQEpzK3E1uhEYLbtcYJF2WJvAQedz4p8IPEc/imz5j7pyffAeH6UtwitSwrzq
 Zsz0UDyy13QCvYqScOnnih7HT/bAntvkjkrGg2JpSMhC/gV8VH6bF3Qh0JhMa1ouWum4
 Xif9hAgZilZyO/xx+uPlyxeYR1zQo2JlUfpPpjtAL5B8lpcVsXRpC73I6bDajoopTWvK
 SiWVEML26ihLBYbM2uvFHvmy9wnXTqonLGsAlRgEr88xOJFQIn2o0DBKbtB+p3kNa0Rf
 n0kA==
X-Gm-Message-State: AOJu0Yzranxyp45cvl20ZXIl/LCUXMvSlJhaSIQDJnVSyqzrVz8kLblA
 7kLr9axEN3bq6spsXD2yFNtG7PKxoxRynXjFuuSKwExo8+n87H7DqlX0ocR9UGu0Hp//DLycV15
 yMdMBliFiQmHfkEetUZnuvlgIteFVznU=
X-Gm-Gg: ASbGnctRcS+ZE9fazEAzNpa5D9I+X6t9DTBoQ0bSaMgMqgSwUbsxvDxxua77G2QV2df
 YWOvfe+Q/sSngbZcpqV1VF/ZPaEzvir4SPPNkF14QNYpI76sCvEA8QJXUv4ni3JBfYs022Le2XP
 pPTndWhkAfpiRTIqtA0SaqPHYacw5I2oc=
X-Google-Smtp-Source: AGHT+IHtCw2vntf0gcQ0WuFkbQDCsDbERkqm9BBwX68+YIg3LRDnYeSC4b9qzghRezAzYl6eIRTst95wfdpJTp8fiqQ=
X-Received: by 2002:a05:622a:408e:b0:4a5:880d:ee6 with SMTP id
 d75a77b69052e-4a5a576348bmr34921061cf.3.1749027564852; Wed, 04 Jun 2025
 01:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250603180514.3826917-1-pravin.pathak@intel.com>
 <20250603180514.3826917-2-pravin.pathak@intel.com>
In-Reply-To: <20250603180514.3826917-2-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 4 Jun 2025 14:28:58 +0530
X-Gm-Features: AX0GCFtf9ZyD84BWa-JF9T-KWKRw9bTM0DPvlLJpCDNtoX_AKlwnKTfCMOo0WVU
Message-ID: <CALBAE1NS4YRZFqGe2s1wQqtNyr9vQe+zL2eU2kfXXAijxpaCig@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] event/dlb2: addresses deq failure when CQ depth <=
 16
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jun 3, 2025 at 11:47=E2=80=AFPM Pravin Pathak <pravin.pathak@intel.=
com> wrote:
>
> When application configures a DIR port with CQ depth less than 8, DLB PMD
> sets port's cq_depth as 8 and token reservation is used to make the
> effective cq_depth smaller. However, while setting port's cq_depth_mask
> application configured CQ depth was used resulting in reading incorrect
> cachelines while dequeuing. Use PMD calculated CQ depth for cq_depth_mask
> calculation.
>
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

it looks like except 4/7 remaining patches are fixes. please change
relevant patches subject to event/dlb2: fix ...
and add Fixes tag,
