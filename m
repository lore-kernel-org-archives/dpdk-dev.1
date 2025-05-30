Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681DDC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 627B94025E;
	Fri, 30 May 2025 15:16:08 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7C50F4021E
 for <dev@dpdk.org>; Fri, 30 May 2025 15:16:07 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-47691d82bfbso37636801cf.0
 for <dev@dpdk.org>; Fri, 30 May 2025 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748610967; x=1749215767; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8PZG773MIZlCN9BbMSzps8g2Uvhw4zGOzIHUAZg6TA=;
 b=NefWgY5/K7v7FCHu/at0EyuySNCkivOJTY8C2bSrDhUaDS8HWKSjT3h67cc4xyOwPh
 JxBT4yR6xo77YrvYSUhPFI2poW/WrPKV17Cylk4HgjjXi0aMRFPdIXAu/pEYfblwOj/V
 gim7v7t6US7LC4g4zG5vhtZF/z/9W8Zc+5DOSZ3/7L/yX1f1IJdoOYG1pXTjh7Os3Xyr
 GO+aRUqwi2T7HpS66jrRIF8Dmh5nY89XXqjFyzao45sheFLkjIKjBXBu5yqxh5JJJW/y
 TK0p4oSfhwjLCePNY0+E+nInFtO/C3M43QATHW8ZOc9LWB/cb+PUvVX2889DvfacNdXP
 vfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748610967; x=1749215767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8PZG773MIZlCN9BbMSzps8g2Uvhw4zGOzIHUAZg6TA=;
 b=wn/+ZIQaH6bfYh820PdNqm0+yaF4qMvXvBODlYIpcxSQQrpwtiRQTwk/nuA9lcd2RX
 oEFyXbUui2Kxm/5AjC5P7llxMv1jYPTWuTxAH7pqPRb1fN3aFBGFlB6BnTWVMO7FD0Da
 ue4UUyJKueDqu8PmZaDRVAEHw0ivsc1xlhKWEcOzrRQ3+ZfYZkZyTL56VhCFtObuFZMI
 xtLse/CktwybmHZuiDTM4fTssGkmnXH4tFi/lThToElhivvLrht4NogV0902EpM+xHZJ
 naHTQuq1ZC/IhQ81JPd+vlFkiWBvs2JfYft05hPLKKPheQ4ZZbp5p3aeeypVEpeoYsrz
 l/mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjmVQ2D0/oSr8bkrcuYw/3kO4xm0yY3Gfrhz6fdX4sT0l1PPmlEnjdTwAM7PHy/Mdk6dI=@dpdk.org
X-Gm-Message-State: AOJu0YxzcdkfyDHOI8Ei/nCcWwXME6mITzTYl4uJ/hhvLw5NLmJbncGS
 m4RZgnAaKKhwCfOFSWIhPpbfjQCGKACJvIDTOnD7P6GBUob9fXNFeO6IOVC04eR5sDgYWZtNXVY
 Hu2fmm73MvtVHpbdvffzpQIPgtagnq70=
X-Gm-Gg: ASbGncvZmZBGFhH8FOse/rFQMd2VWTsRfeY0dwlLzWoI9/7XftKjp2KdcwsNYp5j0Ki
 1lKG28jLfcIVQ9DeIPQeN7So/DJWxTcqbO6vthh88VVUOS7KQOthnjjQNUehZgigY3ZZchGA8E0
 +SjlFwNbkUSuUGXsn+ILn9hHQqcz0qmjE=
X-Google-Smtp-Source: AGHT+IFMoa3FZl60lliap+ifLzpTu808Es+Ezg/amdCtY1LU9ZEaNC5xE2EGgbMiZL8guM15Isp5ErbV689kLEIdFyw=
X-Received: by 2002:a05:622a:2b43:b0:4a4:2d7a:994b with SMTP id
 d75a77b69052e-4a443c8d9bdmr39498291cf.19.1748610966831; Fri, 30 May 2025
 06:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-5-nsaxena@marvell.com>
In-Reply-To: <20250421151718.2172470-5-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 30 May 2025 18:45:40 +0530
X-Gm-Features: AX0GCFu3v0BTwoAPntIkx9AdRbe2tekJy8y-RxB1ksSYK9u9fjXyOnbafjv2hu4
Message-ID: <CALBAE1NK6yYazd6ZV-5Rz-THfoCm4KMr6oh5A74ckPq=EQsGjg@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] app/graph: add custom feature nodes for ip4 output
 arc
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Mon, Apr 21, 2025 at 11:16=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com>=
 wrote:
>
> - Added cmdline argument "--enable-graph-feature-arc" to call
>   rte_graph_feature_arc_init() before rte_graph_create() which creates
>   in-built arcs and feature nodes
> - Added custom feature nodes in app/graph which are added to ip4 output
>   arc.
> - Custom features can be enabled/disabled at runtime on any ethdev via
>   CLI.
>
> graph> help feature
> graph> feature enable <arc name> <feature name> <port-id>
> graph> feature disable <arc name> <feature name> <port-id>
> graph> graph stats show
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  app/graph/commands.list     |   6 ++
>  app/graph/feature.c         | 141 ++++++++++++++++++++++++++++
>  app/graph/feature.h         |  13 +++
>  app/graph/graph.c           |   4 +
>  app/graph/ip4_output_hook.c | 180 ++++++++++++++++++++++++++++++++++++
>  app/graph/main.c            |  15 ++-
>  app/graph/meson.build       |   2 +
>  app/graph/module_api.h      |   2 +

Update doc/guides/tools/graph.rst
