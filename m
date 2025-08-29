Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EDCA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 20:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C359340292;
	Fri, 29 Aug 2025 22:22:24 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 3AF9B4027D
 for <dev@dpdk.org>; Fri, 29 Aug 2025 22:22:23 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-70deaa19d3cso21968816d6.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756498942;
 x=1757103742; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWVyrTjwZLvTju5ZV9NPXqJNjr/dR1Jm5xUauzgC8rM=;
 b=sgmQ++/fnaKG2OE+Z+uEmnR7dxSe0kajSt+uAbb9VHoCFgZKK+4aUxQ4xWPa9gp24H
 QvDaNJb6v43o3K9T6vmv2tgXNT4Wg69zOP5Mfs+6JLKSY40uUN+bJFBEcGSmCWAtI2QG
 h4IFKC+zAIdhDRR/qd78Hss4OZtoaf+nCL2i7t0m17Qpll/1suzDk4/++if3kqAN5XQD
 rm9dhQGnRVHQuojJZQ4KHh/rvSTfBunebmIdnFsm7qY5GsxwqShB1jRhZJIC1zUC8Y2g
 OKeV7JJRJWofMYxuHvrEBqAKTlH2d2RK0yyNkp9Hh5m+n34pOGmUh+67DfihF8apApMe
 coYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498942; x=1757103742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWVyrTjwZLvTju5ZV9NPXqJNjr/dR1Jm5xUauzgC8rM=;
 b=mEJCTPHuCqBCm89XuwZ57NunQ9ZzJDiL8W4QgfSDr3FbqIuKI//gqF8uitPb98LOyF
 Kg6C+pnq3BmiK67BP0sZvVERhgiVW7wqmgBh4fjkXmq+Bwh4PPdDs12karCqEwjfoeDg
 xC8TR9Uyzo2UeMgGHbjrUzXaaGDfHe2ol7Q/LV1e4BdwuPyvzMdd5IL/ZrwFsJ0srsN3
 b7A5bLnnl5XzIG96YiBgHua04mh5M/WywKatNJ7SuDA9cZsxXPKSM8KlKz0cnxDdBQ9Z
 364qUo3q4UpjsSZWi9YvukA1QEk4w8GHcguFbXJ581enh9+gxP4kRPniWXCg1NxSGIKJ
 owVQ==
X-Gm-Message-State: AOJu0Yz+h5hjXlme2ig4cM1qnIFg3Z6HIxTeIodfyzOIvmNI9yRH+DW5
 O1Tt/qVtAyRqqJNzmOybY0YrPjXlQ43/gBBp99xqtKUgTSMYu4GPIBY0ddvjQu2PDpbZhqiJ/FL
 GJhWu
X-Gm-Gg: ASbGncuaYmtIxJ4coQC8S5LUYW4RIAWrKYA61TBOLQOxGaoEn0FgVPTuDPdtqlQnP57
 VaJK2n+CzkqBrSoeBhAx9o5CtYBx5Unoxg+FATpIYmXB/dACITIaryadf8WCklpegnvnOr0bRb3
 VRSMwFAhswHZVXCsqoHsrgfUYfx6q+hrRliE1o4BEf/igQ0xGTveWc44CkkVgkAUcjbCkkxTG+E
 hxF0XvTxXRPdl1yge2x3CLlSqxv0kZqNGDl8auUon0lqPxKaooxMW/GtBkC7aO0pOUR6zsnLJcq
 YpgIAF+TwG9b+VylvKNDfYqrX08+fkgsBw1TyKGrHF4HxsOn403CUpxNXbQWI/uKrfihKRmFJAq
 nneV+S+F9vo4dEPfWsJX7JwB8+9HceRLsEU+8cCIfDZJVJ2QzC6w4uK1RPoZjdgaIWtX2Vw75yh
 ulNsIY+yYMEg==
X-Google-Smtp-Source: AGHT+IHySsGbwz0c3CqVPbVEYd5BORohePfxXkf2nveX6J1JUosVwHPebvo7s4MCu88a9tjWajA7Cw==
X-Received: by 2002:ad4:5bce:0:b0:70e:502b:56ad with SMTP id
 6a1803df08f44-70e5049e6aemr49445456d6.22.1756498942009; 
 Fri, 29 Aug 2025 13:22:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70e6263b9ebsm22232926d6.64.2025.08.29.13.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:22:21 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:22:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>,
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, <zhenghy@yunsilicon.com>
Subject: Re: [PATCH 00/14] net/xsc: PMD updates
Message-ID: <20250829132218.421273c1@hermes.local>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 29 Aug 2025 16:24:42 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> This series introduces multiple updates to the Yunsilicon xsc PMD,
> including new feature support, optimizations, bug fixes.
> Highlights include:
> 
> * Firmware version query support
> * TSO and FEC support
> * EEPROM dump and promiscuous mode
> * Link status and event support
> * Optimizations for RSS, QP/CQ allocation, and Rx path
> * Fix for Coverity-reported issue
> 
> 
> Renyong Wan (14):
>   net/xsc: add FW version get support
>   net/xsc: add TSO support
>   net/xsc: support module EEPROM dump
>   net/xsc: support promiscuous mode
>   net/xsc: add link status support
>   net/xsc: add link status event support
>   net/xsc: add FEC get and set support
>   net/xsc: optimize RSS queue creation
>   net/xsc: optimize QP and CQ memory allocation
>   net/xsc: optimize Rx path
>   net/xsc: optimize stop and close
>   net/xsc: support per port for multi-process
>   net/xsc: fix uninitialized value
>   net/xsc: update release notes for xsc PMD
> 
>  doc/guides/nics/features/xsc.ini       |   7 +
>  doc/guides/rel_notes/release_25_11.rst |  13 +
>  drivers/net/xsc/xsc_cmd.h              | 186 +++++++++++-
>  drivers/net/xsc/xsc_defs.h             |   5 +
>  drivers/net/xsc/xsc_dev.c              | 361 ++++++++++++++++++++--
>  drivers/net/xsc/xsc_dev.h              | 116 ++++++-
>  drivers/net/xsc/xsc_ethdev.c           | 334 +++++++++++++++++----
>  drivers/net/xsc/xsc_ethdev.h           |   4 -
>  drivers/net/xsc/xsc_np.c               |  89 ++++--
>  drivers/net/xsc/xsc_np.h               |  34 ++-
>  drivers/net/xsc/xsc_rx.c               | 248 +++++++++++----
>  drivers/net/xsc/xsc_rx.h               |   1 +
>  drivers/net/xsc/xsc_rxtx.h             |   3 +
>  drivers/net/xsc/xsc_tx.c               |  14 +-
>  drivers/net/xsc/xsc_tx.h               |   3 +-
>  drivers/net/xsc/xsc_vfio.c             | 399 ++++++++++++++++++++++++-
>  16 files changed, 1605 insertions(+), 212 deletions(-)
> 

Queued to next-net.
I fixed the git hash reported as warning with checkpatch.
Current checkpatch wants more hex bytes in hash.
