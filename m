Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF53C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 12:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CCF2402E8;
	Wed,  2 Jul 2025 14:50:40 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3E51B402A0
 for <dev@dpdk.org>; Wed,  2 Jul 2025 14:50:39 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a44b9b2af8so24031031cf.3
 for <dev@dpdk.org>; Wed, 02 Jul 2025 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751460638; x=1752065438; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRIzVCuztaPtFA52n0x94btEuiKSotonuHBDMojIFhI=;
 b=FPFHulx47q32iTpA6xUC9smJ/XniwTWBdLXs7OJ0CjIC2cf/l9JZu7XfkQbods9Fnf
 EJ4OBO0Mf5Ox/l7pICmSj/NceidApoTfRZrgxu6aW5kmk6oipQLUZXrRvggz9fwmSigq
 BNgzOgwMfRoOuKaVdGCIg0kEZUUjDATxa8F1Dp/jj+mv3y1uHBQfKMC3I9o2rRT8e82b
 9ZJz4YJ1Qqao1ismfY4QxjItk88CEjKCEZEMS/tn+S37xrJM99w84qVrpJE3nxROQFGS
 mvozC+tjMK1XZoplHwK5AAYkkfeXmFCdqMvI8EYFhG1RRHWeiEijAMsvkIgzUmT4nx9k
 2DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460638; x=1752065438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRIzVCuztaPtFA52n0x94btEuiKSotonuHBDMojIFhI=;
 b=KISLtoRd5zUJ7rT5hSeFzWjA6v0KVTcAlsjg3hlETT3Wc2NIz+htqtEd1OcNpVFZix
 hD1//WYSreus7spxkz7pPBWTbPmHvHif5uPI2eldrTvMKYuHCHb3TkINVdl6P+wv6+RU
 4QA7zDyqr9b2sb5Lj0SgO41ldsM61sTZWFyGaf09p0IBxEHVAsAuFIXaW+sUVM77vdwa
 cYT32NFbNELIhi3+yJ3F29/T0Z2sbi0c17nTO3dDx7YAfM089ifE3Wu0DTELcggcmosd
 wHbLLAuhzGFznYfqFjty0Eey56dKseRBJZQ8tCdmCFiDUg8gtNSQGrPnlX5KGl+mmusJ
 NHOQ==
X-Gm-Message-State: AOJu0Yx1//EF9fxi0LyTOnJtf+pFfWJ2sPvzdeHou2VFcF3v7MBQUNXy
 V4F1awyvOS2wlHDHKya9Fk2feF6xCfi2xoChEZ8jJ8izs4NA/enIVtsKCsZp+CYSqbJEJzaI5YL
 uJGgT3xgvGYXGIRVi47lBRoci37v1LYc=
X-Gm-Gg: ASbGncskB+aMzrL+Mqd7VODyk4YBbfe6Wcf2cMu0i4WOw0AOvMCPUEB8+C06o7xS8Lv
 ESK298rvrqFk0lqntJ32w+LgrPtupJAu7QEqDOPUpIuN/0gvvnrmInWKeMajFvCty2RejUzD9CX
 5LIgY9Kz2PyCytIc0vJ+qjtQxksRoRyqhJw8wVGuYgrSLZEkGtkRh1
X-Google-Smtp-Source: AGHT+IFcSs4bqLno9ERZRYYVdSvX/fxd+X8q9r7zCJ4c5udQHXEQHeirSrc+umT/AxqeQ7J5FHQSIYegmaBsCH4pQSY=
X-Received: by 2002:a05:622a:90f:b0:49a:8542:b496 with SMTP id
 d75a77b69052e-4a9769889c8mr47196031cf.25.1751460638249; Wed, 02 Jul 2025
 05:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250630023000.719037-1-pravin.pathak@intel.com>
In-Reply-To: <20250630023000.719037-1-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 2 Jul 2025 18:20:12 +0530
X-Gm-Features: Ac12FXzK1Q5KVTueOACCeP3z9GDCSgcw4IBzhUUpC_Q3l61v4G-OuewwwuraqXQ
Message-ID: <CALBAE1MaJ_Y_7wjJO0B55GUDD_6K6Ra-V2xjMrqraQwkqAfKfg@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: update DLB documentation for history list
 config
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

On Mon, Jun 30, 2025 at 8:00=E2=80=AFAM Pravin Pathak <pravin.pathak@intel.=
com> wrote:
>
> Update DPDK documentation for configuring DLB hardware history
> list resource using devargs arguments.
>
> Fixes: 33ab065d0c40 ("event/dlb2: support managing history list resource"=
)
>
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> ---

Applied to dpdk-next-eventdev/for-main. Thanks
