Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8961C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 14:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02D124013F;
	Tue, 25 Aug 2026 16:15:10 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 55D90400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 16:15:08 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-39647184c73so847626a91.1
 for <dev@dpdk.org>; Tue, 25 Aug 2026 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787667307;
 x=1788272107; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PYDZ7BTUUd0ChGShGeVbNwwuDf/ij9iUBLOGshNh4Js=;
 b=QvA8cBTrjvjfid/PbOkr66+t8Q1S+/Ah9OTNYUcZuvAZZQGLyq+4173W9hnKlGMnNc
 mSrpAfP9CaHXB+p+I7xTYusRQ2siToN0HuYc1+8m8vdJcNI6ti41DO39069e6TP2ZEOX
 sQ9DPagEJ/XVZZqG+haexDsTGZHfVJEjbK9ZPTR87t4+bHOnRR+v/gMj87/ba66AG/Ji
 rTYdTWCUwJ1SzsVVHzh1zg/Z+ziTwS8Xd67KLNvTTRYOw8u4x13T5TEWuEbqS6sVevRc
 XUFvgBdKrB3RExzr49d/+Vm3ABZDxyPY3uVvdaiskJANJXvUGl2/NzcI6K4S6n8gyHmI
 +F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667307; x=1788272107;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PYDZ7BTUUd0ChGShGeVbNwwuDf/ij9iUBLOGshNh4Js=;
 b=S5odE9Cvs/6VcmdppfCBPifat3jBnmnB9JGsX9t7VuEzw9BrrQ6RyxHB7xGvchUnfE
 qoPSwdunMxQjYwe3y84BI5c/A+Xdob65nToN8MNxNW01Cfdu1ckkGw9Qk2Xv3fvLNa33
 JIwDY8uZV262c4O0f+EGzEdWsAjTbujk1tGgUcbjKMnBHZXSN+0YIqJlsT7FTaJrkCz3
 uKHqzwod89U4L7IjPaKJfMFjP0msQqmq9W70HHuOK9Ge4cUnBPaYGzlIIscfpnLXBYbE
 HJJtCmeI77+LsJyTV7mTqL17SWDWqeS+vFJn5HHXlcKsWk84WPyMCyUIV4Sk5s3LDukA
 98yQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD+C4bO07LO+4tkOPGLT6iL88hNpx13Y2jv2eCWJVLw6HeZhGfJR0uMmOzADUXAtrqGlo=@dpdk.org
X-Gm-Message-State: AFuF++mE5SExFTBpqCN7K/bVi8DblOKTxUlsLBkzf3XlZankxzvemHqE
 fzulffCpNBw+/z/9Ocqzpo0ugEZV01nVxYJsz7D+1z+byRwhjHF7MelweBExxN0zsqk=
X-Gm-Gg: AR+sD121PJD3CBrwZPp7bjniHYrqVBmRVw/tq329TpkETKM++NEIbUjXJ6tStNcGC6v
 TIjtVe3Kq/HsW7GZ8tdW2/Nsiu0xGfVg6kL6eD0f+xpXSPm78f0tBxErttYLlycvKwbvmHqaOeB
 t1Imr2TxDw/GAQSaJyc5xstMiTgi2yO/eH4oQk4lrEwqWUNZorMQW4Q3xqIilKudQlzEhE9KsZB
 T0z4wLjET3g3HUt1ZzJL1hTMaqFELp6XihDM2rRkBZxerWr9Rz20Jsk1+NXlAaLvkYxj+VVpdZE
 7eAwLQvfJZFIn29mEi/beix2c5pNcK91cMwiKcIoUElEPEkSghtjvSmmAknapvQscP9TZJRZGMe
 +1dnKh2aOYBvjEpiqpSPYb0WXz0bmhHtYF/G3cr+Oz6W87ky0HEZm82W1FJnC87/Z69mjX3EfAv
 jv794RKXSr8TEkjsh1OJ4LyjwlElOOuCaLY8IbMFHB6Of3AppW90llKq/bcAv0r4ExJg35GKBE7
 f1YvLDvzvYfKmB+mF3SSVEw3t35Hw==
X-Received: by 2002:a17:90b:3c45:b0:38e:4f31:8412 with SMTP id
 98e67ed59e1d1-39645a56fb0mr9204254a91.11.1787667305780; 
 Tue, 25 Aug 2026 07:15:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9209fafsm62621928eec.23.2026.08.25.07.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:15:05 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:14:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, dev@dpdk.org
Subject: Re: [PATCH v3] net/dpaa2: hash inner IP for tunnelled traffic
Message-ID: <20260825071455.4bc37db0@phoenix.local>
In-Reply-To: <20260825074255.367302-1-maxime@leroys.fr>
References: <20260723093540.1839619-1-maxime@leroys.fr>
 <20260825074255.367302-1-maxime@leroys.fr>
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

On Tue, 25 Aug 2026 09:42:55 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> The RSS key only extracted the outer IP header. Tunnelled traffic whose
> outer headers are fixed then carries no entropy for the hash, so every
> flow lands on a single Rx queue.
> 
> Extract both the outer IP (header index 0) and the innermost IP instance
> (HDR_INDEX_LAST). Plain frames keep being hashed on their only IP header;
> the inner extract resolves to nothing and adds no entropy. Tunnelled
> frames are also hashed on their inner IP and spread across the Rx queues.
> 
> That a lone IP header does not resolve HDR_INDEX_LAST is the regression
> reverted by commit 2b375df07e48 ("net/dpaa2: revert inner RSS level
> support"): extracted only at HDR_INDEX_LAST, every plain frame hashed to
> the same value and landed on one Rx queue.
> 
> The worst case, requesting every type the PMD advertises, is 16 extracts
> out of the DPKG_MAX_NUM_OF_EXTRACTS 20. On LX2160A
> dpni_set_rx_hash_dist() accepts the key, and plain IPv4, plain IPv6, VLAN
> tagged and tunnelled IPv6 traffic all spread across the Rx queues.
> 
> This is the PMD default hash: dpaa2 does not expose the ethdev RSS level
> selector, so it applies to every RSS request. The hardware cannot hash
> the inner IP alone, as HDR_INDEX_LAST only resolves when several IP
> headers are stacked and a plain frame would hash to a constant. Folding
> the outer IP into the key is therefore unavoidable, and two tunnelled
> flows that share an inner IP but differ in their outer IP may hash to
> different queues. This is documented in the dpaa2 guide.
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---

Applied to next-net
