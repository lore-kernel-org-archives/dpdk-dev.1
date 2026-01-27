Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB71D1953D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 15:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0B640E0C;
	Tue, 27 Jan 2026 16:10:22 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 918F340297
 for <dev@dpdk.org>; Tue, 27 Jan 2026 16:10:21 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-435903c4040so3568434f8f.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 07:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769526621;
 x=1770131421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5uV5qBlV8oxvLUdQpaTRHEQ5lXmRByc1/is4t5dJks=;
 b=0+Nix0waIiYHCwJsxGSS9DpNCJyfbAKRnk2BLaGuwgR8Ic9po4S4IZqRLfniv/xlff
 9e8+y21fCbSvKuBkgiWVhR+1s+9qmfuh+zPJm/K/9ENdV6c6Of/NMZKHpFxzaCiMHeU1
 eD2OlrQbLarbOV7KTuvQhQ+ODtaBmHuxhAma/h3uZMqd7g8hlDBNF6qk9uwMUKhJnhaA
 KE42KAH2lupIBqhVPEXZNmg+cr4y5rhJ/hAlPipO21rwO8jcrDSkadaPTQfjePm/39ii
 Fbgr+1dwGMehprw+MupD6PXhlQGZyfsrbDMcXXpBrpCIUlJSwRtstXAaxZfonbeoPE37
 04kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769526621; x=1770131421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B5uV5qBlV8oxvLUdQpaTRHEQ5lXmRByc1/is4t5dJks=;
 b=V+B+HsVjeUQMJWiB37jG9WuUzogN4SVoE9c/3CgSqBNsyByGnh4f/qQ0Lyi9VjRKSW
 xaF3z2/pA6kOjzrr52UgcFMZcdlXrWUJmma/IVBlctRUjBqz/oj8nvIc4eDsXenrLDhp
 NpnSm7FjqUvIuF0EReW2FS4bek0pPrtrbRMR7rHD9rKylyXzPmiwQIZi0WBAJjOrAH5X
 9lX378FmWv78dX90Uvh1rpgKqiB3xj+OOt9TcMcWyttkvXS3/P5thiceFW0snS9E5/Ci
 NHA8AVru6Vbf16k3fy7kDdBbV7dMTcrKJx2hakIZZVCF0TxJFWool6oEr0w3H8CC2cWI
 SsBQ==
X-Gm-Message-State: AOJu0YwKoFXQMrIqOkTqEq1CIDiWkj2dCf5Y2gRzhkqh8JlyLZaLvBYw
 hlGkfWLnYEnzmCnYK/CxLZSXpHmMj1fuuQ1WWO9tXAheEGDMVe7q7vZeDMr1KurUodUdOyrTMtK
 P6yJW
X-Gm-Gg: AZuq6aJeVt7w/0raIkmaj0NsPJWpqeNZxOGuHiW8zuQLYF6UumxKdvlAqGh/67Qqs3t
 aIkeVoFw2kAmkWxb/pQMvKG8h+MipmValhMC8ew1lAMssvossjsqbSh/7joGkhWqA2ueP/VFGuP
 3595+UxlqiU6CamCaTuCm21d6K3d13WWPjSBKXiGKgpKU3fUYOwCtV/C6pB6S2sekeZy89ll61y
 aFP9J210/AEAmd4VYxOm/fq3A7NflE5nCYC1vKrXJZL9rKutaRRXXONFpetUDv/+EMkoMIhYQFw
 KcOEN46OUHB52mKkeB+lOuf8mEhgwAW6xbbDQfvt8n7F2CuladojriuUkHmUrTYscAEJ09ioDLL
 LMTgCSYUtDTnE2FwEGZI/xT/6cqTz0uexpXePghGtVfX0SV1S5HqrrgZVJi2FO2csrW38NTNV3w
 68mt2PmHykt3Uva47bE2YS7ePD1tQcR09hIeD/2tneeDoEiPaRSarG
X-Received: by 2002:a05:6000:178e:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-435dd04c33amr2799745f8f.14.1769526620905; 
 Tue, 27 Jan 2026 07:10:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm39853104f8f.13.2026.01.27.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:10:20 -0800 (PST)
Date: Tue, 27 Jan 2026 07:10:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/4] improve NBL memory safety and mailbox reliability
Message-ID: <20260127064751.4e830d99@phoenix.local>
In-Reply-To: <20260127025220.190944-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
 <20260127025220.190944-1-dimon.zhao@nebula-matrix.com>
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

On Mon, 26 Jan 2026 18:52:16 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Includes fixes for mbuf/memzone leaks and mailbox state handling.
> 
> Dimon Zhao (4):
>   net/nbl: fix memzone leak on queue release
>   net/nbl: fix mbuf headroom usage in packet Tx
>   net/nbl: fix mbuf double-free in queue cleanup
>   net/nbl: improve mailbox exception handling
> 
>  drivers/net/nbl/nbl_dev/nbl_dev.c     |   2 +-
>  drivers/net/nbl/nbl_hw/nbl_channel.c  |  94 +++++++++++++++++----
>  drivers/net/nbl/nbl_hw/nbl_channel.h  |  11 ++-
>  drivers/net/nbl/nbl_hw/nbl_resource.h |   2 +
>  drivers/net/nbl/nbl_hw/nbl_txrx.c     | 117 +++++++++++++++++++-------
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h |   2 +-
>  6 files changed, 175 insertions(+), 53 deletions(-)
> 

Queued to next-net with minor rewording of the commit message in patch 4.

Improve mailbox reliability by replacing the simple 'acked' flag with
a state machine for tracking message status.

Key changes:
1. Replace simple 'acked' flag with a state machine...
