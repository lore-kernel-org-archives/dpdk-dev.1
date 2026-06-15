Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0211CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC5940A6F;
	Mon, 15 Jun 2026 20:18:52 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id D4903400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:18:51 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso4776207c88.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781547531;
 x=1782152331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9tpIBs/lNKJjuBQe+kS0JlNXc3jF46VJISF5m1yiGs=;
 b=DuknxRlh6337YLiIrsP2+K1WEURRTJ2Fqs25u0P3xYm7o1VUxUdYMkn+p9XfX3bjxv
 x4Zmv5hT7Y2ESQHLURkakzL6B5prm6D+l0SECIWNwGCUHQVbjz7HQkFHrvi0+aoLrPzO
 7t5tk4GdL59+AblWqkeRTL2d99r/U7zSmNv/TUqNFIDwpm32W7sdu5yGmBk5HnPGOwKe
 fbF9/92r5rUyeAw/aMIslDGXBxwl7hT2727Jb4iMfmEaQtt0RoGNnLoO6CKy6FjTy82h
 Sg0346K9Hrh5fGMRvi3LqJ4qMC1MT4S67+bK8/HbxKIh6SUvdnzi2vuQldo02reyfx9i
 TTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781547531; x=1782152331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v9tpIBs/lNKJjuBQe+kS0JlNXc3jF46VJISF5m1yiGs=;
 b=DF4xISADK/XXpYHRAeQaxB8jK+r135bU3CMtYglx+ekfHRLL/XNJDrg6Lv3F2RaJRz
 DvrZJR9e16NEcTfQ27O1+ZTlziKFsx/jnnCmu1iGRqBoMINMSRyUXQt6cc/RxveR9jlD
 YEGixYa7oOPYeKTWaaHuiJ4XxlAJyOY2h4nJwBX6uq6QlulaIY3QOImsF6FANWpn5hvn
 AeLLmUqCSOqQDRnhMfJNN5YBLMEhHDDabG3YUNrvE2NvupK4Ecguydn/hNriYVsMaKKj
 g6Y4k+yfjKLzS1ngFBCkau5yqyY6JO3tHlOTkCJsLUr4GT5yFsXX4ksfYz/tDg5gwhyH
 TEng==
X-Gm-Message-State: AOJu0Yx3DiJu0Yb3KX7C5aGtpukPJHq0x9umLedd6IthHUQfeGh0yOcg
 KBzwjdigepoLT1o9oFODdr9YCYI0c50PnQL9sJ2c+TUrevhRIGj1SKIlbbYTfndLSC9utTv1+Iy
 Sd+lG
X-Gm-Gg: Acq92OFPLvoHNWTWcgJ/TmsqaNx99zSzJn9obtPMDT6NFDmZ0vkOzapm2oVXzGuUZUi
 UlvldOpV967+s1FkTbPv1LZmyZ0TQHOToVvpnk+KHsO2OkfMv+86oo3iRbXPyB830tOxSNT2f2T
 NWADcrpZw1iHTVSr1oQ0/OkH8mCPP0z+pGApWWDVOMQLKjrqwMie6RD/0Rdb4kD88wfaaDfZPB2
 ivFpwxpiKQMZ/KoCgYCgabvDKZjwepfldFSQCLVUISiqHXgT2+6RZpdMZGSU+xgvesnK/GVf3sq
 FtMrZgF7xkrXMILc5yKaZbTIdz52Uzk5WpYorxdBAyimNSGMFglB/Xbkbyi4wnprHrjwUKEgPKi
 vVmc16Pzwesb/k1HxLY20XKUZ5ezmV+8TtM9HG1ZJR0z1ToUaFqsYHjnaHm1SsVIiZQcVQZ3B/F
 BRsS4/pChOBi/qRhJPuI8cjhjVjB+loCyjVrgaxbASDv5pTGIZkvIYpBSRceTHR0DQ
X-Received: by 2002:a05:7022:799:b0:137:fec9:8ffb with SMTP id
 a92af1059eb24-1384bbb15bfmr9427952c88.25.1781547530539; 
 Mon, 15 Jun 2026 11:18:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b8fbde7sm10982676c88.2.2026.06.15.11.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:18:50 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:18:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 07/20] net/sxe2: support IPsec inline protocol offload
Message-ID: <20260615111847.2c83d12e@phoenix.local>
In-Reply-To: <20260614092328.201826-10-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
 <20260614092328.201826-1-liujie5@linkdatatechnology.com>
 <20260614092328.201826-10-liujie5@linkdatatechnology.com>
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

On Sun, 14 Jun 2026 17:23:11 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch adds support for IPsec inline protocol offload for both
> inbound and outbound traffic.
> 
> - Implement rte_security_ops: session_create, session_destroy.
> - Add hardware SA table management.
> - Update Rx/Tx data path to handle security offload flags.
> 
> The hardware offloads the ESP encapsulation/decapsulation and
> cryptographic processing.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Git complains about this patch.
Applying: net/sxe2: support IPsec inline protocol offload
/home/shemminger/DPDK/main/.git/worktrees/sxe2/rebase-apply/patch:236: new blank line at EOF.
+
