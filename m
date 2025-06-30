Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE5C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C14840264;
	Mon, 30 Jun 2025 11:20:10 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9D3F64025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:20:09 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a8244e897fso1645111cf.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751275209; x=1751880009; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qUdV0CddSleUi9jf14jR103oo9nE/RZcyY++Z0MNTU=;
 b=m00NUpE0Qgq1vDkRksn8J5VK0TDcbioB3y8WHbFt3/XE5d/mCcaI2TDlT8wKpcRKGC
 EAdbxS6SFtTh1t3ottYEORCJO4I3DnAOsO4dDbzFP/K8IDcS8wytTu2VulJEIhhVkBxB
 85T2ytGxukUmgbDE0aL9jNi9o3h2R37W3r/Sd4aOYfMuM1GaRRBIt859X2kcbIGFTo5j
 DHwIBv6/ooT23zs1ES2Hz/135TO02lArjhN6dvVjf49klQBO/RBbWrS2Pw9B1zhqpc2P
 M+eUGXXUUOfsBNQgvbZ2ZIzoYXKlkITKRllNB1mkPRv0IDRqlLD1RNUFWI026GN4vykc
 e2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751275209; x=1751880009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qUdV0CddSleUi9jf14jR103oo9nE/RZcyY++Z0MNTU=;
 b=PZkBGommwDtx02FwKhKMPvZ9Z0bMyhKxtlghDnPcQteBkdD2nlfon8OB3TGivOja5J
 8qVovuK+fsjjHrVSia1NOP3rDFdTDAbG7mmDcoeVn4slDXaNjJuKZD902xMDeyt+TgBR
 IFuNqQGyK1v696DdHacasOyWfJDM3iGh6KVCbUk1e+QeT1xkBk5BAiYZ2S/e+KIxxAv0
 lX/mUML1bpn1wCDR0ihudylsptfWYRFH0I3VaNVUl0vKhEvYyKX3v8iJZ+GrQhNf8itL
 GLFW891nb8EJSKcYvhjMq3vGJGYUmZCgt//Qy2wjz6NR9NZehfIYGjmSlxIgG6L2QXfo
 lH1Q==
X-Gm-Message-State: AOJu0Yzm3Ta6d7B8gLstdFhViVxqzzac/37HHVIctphk0LxCwPk69VNA
 qpYm3MTbItLkYtsZdT8jLKe6yuMWGq/PlGAR8M7ugLnBxCwHdRl5UUYEgRyi0Fg3vOddKBPjeGY
 zsHZOMMD6Gdh6t7EWoGUE/CqXx5VfyI0=
X-Gm-Gg: ASbGncv08Khz7GtfC44ZRMzR5ngdsuMGevpylAc6XUkV/1GqMjcxieen2z+73M+0eXf
 F0Pe8MYul5FjPaiy7CDgsU/GQr361LaK9x0Ai80bv3cu8rietX+if/UzZgZCHmkdZ8/03Z4LqDI
 6reC4Jvcia8qZ0+T3MLziPTNF/eZhn/h/UEK2HyGlnLw==
X-Google-Smtp-Source: AGHT+IEnUayJuGCeea1gmgOiMWGdxWB778fwBPSguLBrZbnVoQuEnh23VQKKpc9tW2MRpaHqDP+sevS5dTHIfZDkvgE=
X-Received: by 2002:a05:622a:58c8:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4a7fc9d5228mr200263171cf.6.1751275208793; Mon, 30 Jun 2025
 02:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250628045112.655999-1-pravin.pathak@intel.com>
In-Reply-To: <20250628045112.655999-1-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 30 Jun 2025 14:49:42 +0530
X-Gm-Features: Ac12FXxpVUGE0cTJ-gu8iWDsjN5H64POlLYKU5783btsBiWOy9heiEn7zNAz9kI
Message-ID: <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, harry.chang@intel.com,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
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

On Sat, Jun 28, 2025 at 11:17=E2=80=AFAM Pravin Pathak <pravin.pathak@intel=
.com> wrote:
>
> DLB2 port interrupt is implemented using DPDK interrupt
> framework. This allows eventdev dequeue API to sleep when
> the port queue is empty and gets wakeup when event arrives
> at the port. Port dequeue mode is configured using devargs
> argument port_dequeue_wait. Supported modes are polling and
> interrupt. Default mode is polling.
> This commit also adds code to handle device error interrupts
> and print alarm details.
>
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  doc/guides/eventdevs/dlb2.rst              |  20 +
>  drivers/event/dlb2/dlb2.c                  | 236 +++++-
>  drivers/event/dlb2/dlb2_iface.c            |   7 +
>  drivers/event/dlb2/dlb2_iface.h            |   8 +
>  drivers/event/dlb2/dlb2_priv.h             |  18 +
>  drivers/event/dlb2/dlb2_user.h             | 112 +++
>  drivers/event/dlb2/pf/base/dlb2_hw_types.h |  70 ++
>  drivers/event/dlb2/pf/base/dlb2_osdep.h    |  46 ++
>  drivers/event/dlb2/pf/base/dlb2_regs.h     | 149 +++-
>  drivers/event/dlb2/pf/base/dlb2_resource.c | 825 +++++++++++++++++++++
>  drivers/event/dlb2/pf/base/dlb2_resource.h |   6 +
>  drivers/event/dlb2/pf/dlb2_pf.c            | 223 ++++++
>  12 files changed, 1711 insertions(+), 9 deletions(-)
>
> diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rs=
t
> index 8ec7168f20..a4ba857351 100644
> --- a/doc/guides/eventdevs/dlb2.rst
> +++ b/doc/guides/eventdevs/dlb2.rst
> @@ -477,6 +477,26 @@ Example command to use as meson option for credit ha=
ndling:
>
>         meson configure -Dc_args=3D'-DDLB_SW_CREDITS_CHECKS=3D0 -DDLB_HW_=
CREDITS_CHECKS=3D1'
>
> +Interrupt Mode Support
> +~~~~~~~~~~~~~~~~~~~~~~
> +DLB dequeue supports interrupt mode for the API rte_event_dequeue_burst(=
).
> +The default port dequeue mode is polling. Dequeue wait mode can be confi=
gured
> +on per eventdev port basis using devargs argument 'port_dequeue_wait'. I=
n
> +interrupt mode, if the port queue is empty, the application thread will =
block
> +on the interrupt until a new event arrives. It enters blocking mode only=
 after
> +any specified timeout. During the timeout, it will poll the port queue f=
or
> +events as usual. Interrupt mode uses the DPDK interrupt support framewor=
k.
> +
> +    .. code-block:: console
> +
> +       --allow ea:00.0,port_dequeue_wait=3Dall:interrupt

Adding other eventdev PMD mainatainers.

Looks like it can be a generic feature. i.e set this option is dev_configur=
e()
If there is no objection, Please send a new patch around that.
