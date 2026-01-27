Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F4ED19512
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 00:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C9AE402C1;
	Tue, 27 Jan 2026 01:34:36 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id CEA6C402A7
 for <dev@dpdk.org>; Tue, 27 Jan 2026 01:34:34 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-435a517be33so3106071f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769474074;
 x=1770078874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPzbCnsDKzO9elxFDNK1KLaGzEufB6//7lk+ieb2gwY=;
 b=vt2pGYl3KJ9eVpow1jiWYWNME6R3H0P7lF/+lZiu4Ud8TRH2P/JBwP8SOYaKgRBwu7
 nkxJ6usfXwc0kuW2QSMbCLM5Yoe2CdyqVaVQCUpFLif1t01T2X9IG8RQf75JihAgAhsI
 5VSF+VA2OS7Pw6d33l1vrysiUP34xch2RXy+bxd91h/Pi90mO3wBIg4m0lH4TTIJWgcY
 PGL0RpiqT9oALDYgdCIX0prZDjwYSgi4K6S4JBeGv4feXjRUTYkpbhMNCLlQSFs4ZlXe
 WBR0v1J07zFV0bSCsX7nD9TdqKeHTeyXlkdgzS9mMMK54P/qxpoOmsxDSdrYMxDGvt2F
 saLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769474074; x=1770078874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPzbCnsDKzO9elxFDNK1KLaGzEufB6//7lk+ieb2gwY=;
 b=m7I0pVl2UD1smRfNGf2X4bkJUdS0b1ig1WG6nRa650no/wKnuKMQdl0cSHnrjktbKo
 igPEEYSmFg3d+NhcL84CpsfLYJFypYMJHSMVfdyowHvQrSOH7/UPseTHV1defPlDdNeU
 /ntXZB3b/FO9XkJ9y3UZoMFoC2IL8SfpRdPgS+SIulJxNIosxTswl1BIdNxBKYKm89la
 23L02BrQ/zol6zBm9LbzljdWTh3szdO9eJHwn51twn6qCDn+Ux9G6Yhj3qbcMp2hUXIr
 hE7LEoWbQGETrX9DrjSvIuZNO8rNlKZMacScoKtOe7T5wvXgb18jz1/roxJUoAsl1EDs
 kSGQ==
X-Gm-Message-State: AOJu0YxLbYT1uumShbeqnkb4334etuC3GMLIpL0RCbzFuOxYQHRxQK8d
 HU3LGYAfj3HMyjifaD3p6XdYRSLGh9rNDhlEySB3ZRGioVOkshcugmCJe1OGfv/NGolvZJexl/K
 O2DSG
X-Gm-Gg: AZuq6aLEr93OOAHG6Tux3S3t3BN3aU0/Rp39RxpXDWE+NzRqZDyNcex/twLjDKFlz2r
 8oPLHU9LVAvnqp9hhdVjq2KfLfoUZb+6uSalS4n4pcO1SfYG4ptS72vFPpJ01+G3saLqXXcxAjS
 mCOk/mjZ/MTacMa9DlvVlVC45uJfsc2Z46UOSiSH+JylTMAUMQdOXrRzIK2NhRMBkNsKLSb/yjT
 bgdGvZOpogFJzFTaY76663kOJR3+jquu0qtmVgjcKjcV4whZqDMsug/gI9MuXGsAnuiFcg101wH
 jvJd8ygcHxEJ6xqtLEX76EimxdCPPgOpMkXSisexy0nQ1G5luUaO/X58MXqFKY6b5XLsd4RL8rr
 HmYmcpAnGJxWv1bjuHhwhdpkmWVzFHOnNX4ty4gbSh4LpvssbJ1Mk9rIdKiOBsUwe/ODwMZYd8n
 ZYIQRvVQ43LJ+FstwrV4PMRBF2Kr/5EyjfcD/V+zXyFkIcQwG3F0Ar27AUOv9S2PM=
X-Received: by 2002:a05:6000:184f:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-435ca198c6bmr10052260f8f.47.1769474074108; 
 Mon, 26 Jan 2026 16:34:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e715d3sm34037267f8f.28.2026.01.26.16.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 16:34:33 -0800 (PST)
Date: Mon, 26 Jan 2026 16:34:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 3/6] net/nfb: update timestamp calculation to
 meaningful value
Message-ID: <20260126163427.19050072@phoenix.local>
In-Reply-To: <20260121170120.268553-4-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
 <20260121170120.268553-4-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:01:17 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> The resulting timestamp wasn't monotonically increasing value.
> 
> Now the timestamp is value in nanoseconds (Unix epoch).
> 
> Unfortunately there's currently no safe mechanism in nfb-framework
> to get ticks from hardware to implement read_clock function.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>

While review this code, noticed some things that are related.

1. Why is nfb_eth_ndp_rx in a header file, it is only called one place.
   C code should be in the .c file.

2. It is marked as always inline, but since it is called by an indirect
   function pointer, dev->rx_burst it is never going to be inlined anyway.

3. This could be simplified.

	/* returns either all or nothing */
	i = rte_pktmbuf_alloc_bulk(ndp->mb_pool, mbufs, nb_pkts);
	if (unlikely(i != 0))
		return 0;

	/* returns either all or nothing */
	if (unlikely(rte_pktmbuf_alloc_bulk(ndp->mb_pool, mbufs, nb_pkts) != 0))
		return 0;

4. You are fighting against line length here:
			if (nfb_timestamp_dynfield_offset >= 0) {
				rte_mbuf_timestamp_t timestamp;

				/* seconds */
				timestamp =
					rte_le_to_cpu_32(*((uint32_t *)
					(packets[i].header + 8)));
				timestamp *= NSEC_PER_SEC;
				/* nanoseconds */
				timestamp +=
					rte_le_to_cpu_32(*((uint32_t *)
					(packets[i].header + 4)));
				*nfb_timestamp_dynfield(mbuf) = timestamp;
				mbuf->ol_flags |= nfb_timestamp_rx_dynflag;
			}
   Either add a helper function expand since current DPDK max line length is 100.
   It looks like you are using pointer math rather than a structure.
   Also does the driver just use timespec? I.e is it safe in 2038 with a 64 bit seconds?

Something like?

struct nfb_meta {
       rte_le32_t rx_hisecs;
       rte_le32_t rx_losecs;
       rte_le32_t rx_nsecs;
};

static inline void
nfb_set_timestamp(struct rte_mbuf *mbuf, const void *header)
{
	const struct nfb_meta *hdr = header;
	rte_mbuf_timestamp_t timestamp;

	timestamp = (((uint64_t) rte_le_to_cpu_32(hdr->rx_hisecs) << 32) 
		    + (uint64_t) rte_le_to_cpu_32(hdr->rx_losec)) * NS_PER_SEC;
	timestamp += rte_le_to_cpu_32(hdr->rx_nsecs);
	
	*nfb_timestamp_dynfield(mbuf) = timestamp;
	mbuf->ol_flags |= nfb_timestamp_rx_dynflag;
}

5. Using volatile for statistics is unnecessary and slows down
   code. Since only one thread can update them there is no need.
   It seems that lots of drivers cut-paste this off old code.
   The one exception would be if the driver supported TX lockfree
   but in that case it would need real atomics.

6. Driver should consider getting rid of variable length arrays.
   VLA's are a bug trap and a GNU extension. It is perfectly reasonable
   to have an upper bound on burst size of something like 64 bytes.

7. Driver could use rte_pktmbuf_free_bulk instead of loops in partial rx case.

8. offload flags should already be set correctly when mbufs are allocated.
   doing mbuf->ol_flags = 0 is not needed (but harmless).

9. You might consider using rte_pktmbuf_append() which would standardize
   update to mbuf and avoid the current situation where if packet received
   is bigger than space in the mbuf pool, the driver will corrupt the mbuf.

10. The driver probably haven't been tested with multiple ports.
    But the expected behavior is that timestamp is configure per-port.
    Most drivers have a flag and only add timestamp if it has been
    configured per-port.

Since driver is using time since 1/1/1970, you can just use UTC time
for read_clock. Except if there is no time sync between CPU and NIC.
Maybe just compute offset once on first packet received?

Transmit has seem inline madness.



	
