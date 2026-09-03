Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B8C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF104026C;
	Thu,  3 Sep 2026 19:53:37 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7289440144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:53:36 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso161757a12.2
 for <dev@dpdk.org>; Thu, 03 Sep 2026 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788458015;
 x=1789062815; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FsC9lINhy3RzD+nW0f+2si+MQofFhIAjxMuv8ebm/oY=;
 b=X1lBKlIumR947pozQktY8ss5cM5pTq82LPZuw5XVWj9M4AferCIn015BSplx4dWlSd
 PqSIww2U/1h64WRkoS9eyzR57EXuagPWn6HXtMqnZ0dqRfZK8inT6vz+wNXhDua+wX6R
 fViys5wz9Avpb2/uwtiv96g4CzMrQDlq8AH3lAeIbUw3wfaMJ+PdTIN0BjR8RwaJGz5O
 Q0dY80Paa+jdjBTQ7f6yU6E2Cq0KOhA6ZKCNbpsAkh+eiqYxt3MahjAJMcrDKa3iRcp4
 r+t1l8rt5UkDDUznI3UdmtXuYa/E2//TpH84/XIlSCfIoTdcuA7BncEcdm53Z2GKUfTK
 ChJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788458015; x=1789062815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FsC9lINhy3RzD+nW0f+2si+MQofFhIAjxMuv8ebm/oY=;
 b=oxLq8vykJzoG16LMarQ4MAVRniWgbkxw538dfzzUIW7Rv2YrLPtw9uKXdBsf5GPdE4
 o5jVhPLwH7lvxd/enjBL0ENA9PwVkh5MIYHN20kDOYfg7Q/fKfTT69SSVNOn11B9vK23
 eX0FukfmshXqLfwqjlA7p21R56CouFgWheFqZAzHQ83NwDZbzDjZvBDjLu2oA8o4pvJh
 BXcJcf42Xs4HvghGhuJxCBSFfW5wReizcvgR4RhpsIkppu0zeN8D2++++cfkG5kouotx
 0hgTeIxFd9wQmMUxBc5mzKQ7HG54zsTJpIFpESURA6fLOSEr1o31HVbLM2GaSFZQqZ4J
 Q5+w==
X-Gm-Message-State: AFuF++nvQc127z4VgvXwY6Ysv6bf0GoJCAaLRSVphecRlY9j5MAK+8MP
 Zox0zZd3/IrClBlCALNORZL/fYfj0otrO5en5rVMd+Qcap3OdilMLivTrrA3PL/Todg=
X-Gm-Gg: AYBFou2tm6t3PFKcIhhp5N8elqn8CTBcpdwlZ/ZNAHj7f1R7fkv6n/Eq5jyv+mXQBU6
 jwDGCShfaHmzKKiEawN7iQLR5SJcYh1r85dehhRN7JAdEM/OQvgJf184mLww1IYHjTr1PgQeNGC
 onIFT73nXdd9fu1CI1tD10I3ThTg9Fu4cXu43PMH1pGPrjlDJEWUrebE1zPlyPP8yJwG2yP1rPl
 qcL/set+Q8s01vI4b2sUZaNcv7q/VRpH4QqOlUokbCbGkDMRvgt7wtad1p6UjkvWnDC4TPXiIGs
 Se+4dM65R/l2sstKa63dACDDF51dpwRKWoFzkxEgejjGzDfhfV0dkVjVWM0FjqLxAw8eIotI79l
 GGybmzNqyZY7qqcWpJeri5aRp1Pld+duxpwggpbE73LMm6JFJ0Zv1Rn2oybwpvia0mPREkBE00D
 xE33gUHSLBvRPHORfLj2zyzhQ/XgJ1NxR0L7DAeb9ek9B8vhOd2RU8AZmVlHx2uII7F1wwF62S1
 rwJxi1mZeiWmalrlgQyhP0d8casxw==
X-Received: by 2002:a17:90a:c10e:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-39b2622b3afmr234592a91.18.1788458015236; 
 Thu, 03 Sep 2026 10:53:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e6e3asm7121864a91.2.2026.09.03.10.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:53:34 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:53:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v14 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260903105325.4161b387@phoenix.local>
In-Reply-To: <20260903113219.3788050-1-wang.junlong1@zte.com.cn>
References: <20260829074155.3524274-1-wang.junlong1@zte.com.cn>
 <20260903113219.3788050-1-wang.junlong1@zte.com.cn>
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

On Thu,  3 Sep 2026 19:32:15 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v14:
>   - All Warnings AI review issues have been modified.
>   - Some info issues have been fixed, but the remaining
>     info issues cannot be fixed for various reasons.

Applied to next-net, with the release notes indentation fixed.

A few informational items from review that do not block this series;
they can be picked up in a follow-up if you want:

- zxdh_dequeue_burst_rx_packed() and zxdh_queue_rxvq_flush() index
  vq_descx[] with a device-written descriptor id and never check it
  against vq_nentries.  Patch 4 adds exactly that guard on the Tx
  side, so the two paths are now asymmetric.  Pre-existing, so a
  separate hardening patch is the right place for it.

- zxdh_refill_desc_unwrap() is a near-copy of
  zxdh_enqueue_recv_refill_packed(), which after patch 3 is only
  reached from zxdh_dev_rx_queue_setup_finish().  The setup path is
  not performance sensitive and could use the new helper, letting
  the old one go away.

- zxdh_queue_notify() is called whenever vq_free_cnt > 0, including
  when rte_pktmbuf_alloc_bulk() inside zxdh_refill_que_descs()
  failed and no descriptor was made available.  Returning the number
  refilled and notifying only on a non-zero result would drop an
  MMIO write on the mempool-exhausted path.

- Split-ring leftovers survive the cleanup: vq_desc_head_idx and
  vq_desc_tail_idx are written and never read, and struct
  zxdh_vq_desc_extra's "next" is written by
  zxdh_vring_desc_init_packed() and never read.  Dropping "next"
  would reduce vq_descx[] to a single pointer per entry.
