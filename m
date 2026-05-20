Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881F94065F;
	Wed, 20 May 2026 11:48:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 642FF4029D
 for <dev@dpdk.org>; Wed, 20 May 2026 11:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779270481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lwGbk52ZA9XQZWjTcXAVFfM3qI4w8/CL6ns35hlEvo=;
 b=E/g+xhJ0s4nZlfwODbGKdsHRf5LiygqtB3uQiG+UZWBlpxlKxxYYS78ezqr2v6j/opwNaY
 7T7Tl2N2s7nse+8OWEWP+c6xoCD/rZqtxy8yfGZQPwSH91QCeDAzqXokliEpLhzBZ6BYrP
 p3/KHOSUM5svNt0CSsNDUzSANV2Y0F0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-izNujgtANKmoW7NUg8XpQA-1; Wed, 20 May 2026 05:47:59 -0400
X-MC-Unique: izNujgtANKmoW7NUg8XpQA-1
X-Mimecast-MFC-AGG-ID: izNujgtANKmoW7NUg8XpQA_1779270478
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a886a993feso2913652e87.1
 for <dev@dpdk.org>; Wed, 20 May 2026 02:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270478; x=1779875278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lwGbk52ZA9XQZWjTcXAVFfM3qI4w8/CL6ns35hlEvo=;
 b=JAQT/y6QTueEfhnHP1xM0pOrJnp7ev4jM5vdsDKdYeiGOcry+MyKroCXPh2xSfWNFH
 Nm7JkQe5IKq2jj1H/r58qvxABNTbTpnW8+L17aR1G5iT9A1BywXIEHCnRllpwFtswul1
 V4ruUNIts3Dc0mbuMxLnGbIxBX2HnqvK9qO73a6df7tCV288ywf95WcE1Ctsv4CxHWDR
 +awy2AxMs+VFPOAV7dpmnw7G4eoGdk5s+UbmM7kVPpXaOc4ubbZ0mD80LLbG/qSdp5lI
 +LERwYzRfaQrOk9NOIZ42YlxQoZScaABXcIA4mY/XSGih4kKF+xZOhf7jSXPUSFmtQKB
 4woA==
X-Gm-Message-State: AOJu0YxqLTdVIoU/BlddsrAi1N5GTRsiyJp7K1xbfSfGrtpGgWJzMT7Z
 opWHra6+0P/FvnSZBnTPqNbW4ZDZ3d8Il0Sa62smjgXgcS/pYrsq1thwbc4hz2NsCT+0Gh9lQIg
 1sF70TO+BVpz7UnCTcurCg0jGjErLflMaIt5ONk7v7/ZI0ASF6XCUbCDw4N8KjxYFkhCK0G/66J
 PLToIWefk1fziPDpOtKYo=
X-Gm-Gg: Acq92OE7w3V1/4vp6M9TWwcvi89ps9tdDyLYmkp4rIsJ15bhJdEfd/nUwD6kyrsmkZX
 1bpBS8GAGNQDWm5rziMoJEn9MWO4uohrJ700Bd4XwwvXOqIkRXwRlbgVqTO5a11U690DUwK41M+
 +KE1Ifx5XuKQDBIJ3P2q8QT4llrgeSDfxSORVJaO72BQFfukuB/iKY25MhBi7HYYGXQE+bxOXgC
 /DrGHqHV2G1TKRfzekDjWpSAG0d4y1XT4VaUsVGDvIFsnnn9Kp85ZJQqXLEb08sgen8Wg==
X-Received: by 2002:a05:6512:3d03:b0:5a8:6f4a:6a62 with SMTP id
 2adb3069b0e04-5aa0e7753edmr7128127e87.41.1779270477975; 
 Wed, 20 May 2026 02:47:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3d03:b0:5a8:6f4a:6a62 with SMTP id
 2adb3069b0e04-5aa0e7753edmr7128119e87.41.1779270477459; Wed, 20 May 2026
 02:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-9-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-9-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 20 May 2026 11:47:44 +0200
X-Gm-Features: AVHnY4L5RB5jqhvhgjDCKYAhj3SVQL1Q28CheC8XyHh1XDrJri082oP8k3qOw8w
Message-ID: <CAJFAV8yGDEt-f3KS=RQiEDh_yCd5S-pZAQ_NVqE_QEz1MvKppQ@mail.gmail.com>
Subject: Re: [PATCH dpdk v5 1/5] Revert "net: fix packet type for stacked VLAN"
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GJIeScWxNuHs7jfPQ7rLgsaFU9qf0vmslm6pQ1vBDJY_1779270478
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 18 May 2026 at 15:28, Robin Jarry <rjarry@redhat.com> wrote:
>
> This reverts commit 1f250674085aeb4ffd15ac2519a68efc04faf7ac.
>
> rte_net_get_ptype() now uses |= to set the L2 ptype inside the VLAN
> parsing loop. Since pkt_type is already initialized with
> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN (0x6)
> results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single VLAN frames
> to be misidentified as QinQ.
>
> This was detected while testing DPDK 25.11.1 in grout. The net/tap
> driver calls rte_net_get_ptype() in tap_verify_csum() to determine the
> L2 header length. With the wrong ptype, l2_len is set to 22 (ether
> + QinQ = 14 + 8) instead of 18 (ether + VLAN = 14 + 4), shifting the IP
> header pointer by 4 bytes. The checksum is then computed on garbage
> data, causing valid packets to be dropped.
>
> Bugzilla ID: 1941
> Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
> Cc: stable@dpdk.org

> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Acked-by: David Marchand <david.marchand@redhat.com>
Just a note that this commit is already present in all latest LTS releases.


-- 
David Marchand

