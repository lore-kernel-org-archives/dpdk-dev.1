Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007BFEE4EE
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 19:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C75402C5;
	Sat, 28 Feb 2026 20:46:24 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 56CA44013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 20:46:23 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12732e6a123so1538015c88.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 11:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772307982;
 x=1772912782; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKF89rar/YJHEo7jEiy+tEDBix11vU85ro7UqLPz/II=;
 b=Gl1bWx58luTDsoMC09SCeVUW5UWKLPg7xfP3wS6xPEGUgYwiSbM24yferbsD6C+5cu
 qhdgVtYlKu0/XkvP6Lx/BBY6XnI4LskAf8DalhBJoEcy9LOSZUbDq3FH9GKbj+b4JkvL
 pEYL5zPU5qrIkUFusciPypEyp1Pd4tofK2oejFQOIBS70FSn2pGPKdwM93Nb0aVgbJR5
 uCLdhfntDYLDlXPi1K2IA3VsyMQi8V371d+Ymb45H4c991+W8G6lcA2Iqu7LUhM5okf6
 gQb2XoDB7bg8oMtJapKN1u4Uc224IJn1QGwsobCUgDnBQOkJmqrHF/nVqpwO290kfJOv
 OwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772307982; x=1772912782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RKF89rar/YJHEo7jEiy+tEDBix11vU85ro7UqLPz/II=;
 b=X9w+kg55oosLECSGFfvFaGXHSrAjLT+BeQwAotJ8gnt10o4stpC9+aK0keuP1/AwUl
 2PvXHLwKHzOlP6jkYj2MGKr0DPX79O1Bc0rzMgC90A8xnoTfJzGR5sh+s7zSpRTnWF0M
 ytU0KgAOilAgZc8r32ECVhcX48Igjlkgq75oWWjXNcRm5ZSLBEBafcs/B0gwWRB4DFoe
 S/cN+8pc4x7sGLLj1r7FUeEPvxNS35G0evwFr1rEDu+wuMi1ykF+wlPyYPO8B13gCFsS
 hXRCaUcuw7InfgUyzyEKSOXI9lESXh+vGNTl8OBC4aUCeE+lt0170uX4UMzgyWBFs/ym
 p1FQ==
X-Gm-Message-State: AOJu0YxdKwPKoQoD22984xGpZgE38ISdvEuGLplznXsduNjeQzKbO/mb
 VhIBQOLTDtPmksZeb/KMf6bxQAhHU92Sz9HJ3UEdf+h9PFMhs/L+Lso+reJ1KUuNzmg=
X-Gm-Gg: ATEYQzwiQfQYuAFznNW9iR86TORoJ8oFtZpthqRQMrgfZBHbfltRzFf7dFaEfRZPn2R
 +YoUTQcbetdzzTC6+WIGpMUNe/5e4B8oTYHreLa35hzG+ylP8za9/MHcUYmVmpO3MHUWqVg5GqK
 EUvN0ZN5Nc9+7H3ZK/SnVl6ReBcLSTHJXn8BMBBdDZCIw5bd0fYkK5Q/Z6d3Ujd8WB/vn279Imv
 MVlizfI10Jq+HD+qlxUkFxOZhcHGiszuqe10f/JYxZAeFKVbWpnGEXPWHzXNF7Xw87zE8ELf8rn
 80r9QiFa55tKmbkJgmWWzIGFrbBilmMkSuVIyV08LW3DVU95ClwNF88Cxqzsg7y7xGUQVJM3dSt
 oPtBwYW/zURIGiELFiTEodOrDbRrPyPuhykdZ13I9rTILi1g4BkXFJSPPcudieGApwLWBlyOOOa
 Mt/5+4PdVfY1H+Zv1h90JdhZH0/2FAfavlfIYgz4VzRpib9iVleCqFCvUdz9Yr2YOG
X-Received: by 2002:a05:7022:24a0:b0:123:2c98:f6af with SMTP id
 a92af1059eb24-1278fccb405mr4056661c88.14.1772307982116; 
 Sat, 28 Feb 2026 11:46:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a5312dsm7886921c88.16.2026.02.28.11.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 11:46:21 -0800 (PST)
Date: Sat, 28 Feb 2026 08:41:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v5 1/3] net/axgbe: add external PHY read/write functions
Message-ID: <20260228084128.5df65dba@phoenix.local>
In-Reply-To: <20260228143750.626-1-ashokkumar.natarajan@amd.com>
References: <20260227084323.689-1-ashokkumar.natarajan@amd.com>
 <20260228143750.626-1-ashokkumar.natarajan@amd.com>
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

On Sat, 28 Feb 2026 20:07:48 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> Introduce helper functions to perform external PHY register read and
> write operations. These helpers currently support only IEEE Clause 22
> PHY access, providing a simple and consistent API for accessing
> standard 16=E2=80=91bit MII registers on external PHY devices.
>=20
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---
>  .mailmap                           |  1 +
>  drivers/net/axgbe/axgbe_dev.c      | 56 ++++++++++++++++--------------
>  drivers/net/axgbe/axgbe_ethdev.h   | 16 ++++++---
>  drivers/net/axgbe/axgbe_phy_impl.c | 45 +++++++++++++++++++++++-
>  4 files changed, 85 insertions(+), 33 deletions(-)

Applied all three patches to next-net
