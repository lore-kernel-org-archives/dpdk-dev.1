Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667FC5AD4E
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Aug 2026 19:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B2C402E8;
	Sun,  9 Aug 2026 21:18:15 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9998540298
 for <dev@dpdk.org>; Sun,  9 Aug 2026 21:18:13 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so12975305ad.3
 for <dev@dpdk.org>; Sun, 09 Aug 2026 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786303092;
 x=1786907892; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=31oOqPLr5dx8Fy7hjrd76bnCGsnQmyyWNSD+JEGnBWM=;
 b=necB+12llMJZP3sozkQX0/iy0SnvW5VMdeUSVW2XPiflmDh0Y93PUP/skmcwen148v
 dDQMDO/LfQiwIjrz8IVU9zSMLN4bjCSfkzoUyRZc9v5QtGsJ7sea/3i9Q30AWu1PkB12
 wOI6rELu+khUa2XaHfCWIL0cwR4fk9QkljQ9aZXxQp/hlEuKdS6WCvGi0niFpKefuqGT
 qT6K0+pbozkEbfLnNkh5m/5UcQ3i84yDk/8XvANZ8Ic3te89i3SSP/Yi1hrBlih1bDHL
 p2sdFw/HIgtTASb09Z+teg0XMErGLMuDz1Uw0ZH964odLtTYp7NqTjWYvRzfo/wRg4Z+
 I62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786303092; x=1786907892;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=31oOqPLr5dx8Fy7hjrd76bnCGsnQmyyWNSD+JEGnBWM=;
 b=pGYjXUwVefYxpWqJSIp4GOwrcWeTX4G/UmpbckTpWCD2/BZsNrWn731xbyw1Bvf7AC
 crmY8vS+9jGlog7idDnRYsvgaMfw+Pw6UHLrsIKe4PCmIZjctalTM62wowyyufR5oG5q
 vdNGq4jov34trtbYQV4XGTmx0bHi87OuR4YX1zpKMoRdGw/U6/xX9T/EgIcYzm2F6n5f
 aNV3xhYYwr2bhNDSUWSHtbBMjLYUYbchJDKf8PO0hfpv9yOd/8sWtA/aZcGhayfbdPgB
 Yfb8OnMIl6fhE5Crh9Ak60o+dPxDs9Ph+Ew4NPAbGRonm0CP8Zk6NQn1J6/YVVQHnHqQ
 zHZw==
X-Gm-Message-State: AOJu0Yzw9K5etGxMzXeMr6EZoc9Z9U1JmM9A2Ww2svZVLfTuPLje5ksQ
 rPXXvIa/VpC+f/mOGYCIttLRz4c98wbMRhx2e4sIb+aMelRIZkZaePJKtfFcDmOXeOA=
X-Gm-Gg: AR+sD12qVGMryl7zDtmMTHFEhM1S1H4cRepfQLT5TFXfIH4Uy0gsv+G8UI7xR/rpA5R
 ZJmjtTx0jOzp+XXvqIm5GOSnMNQHfE+K+1xfvr8RI0vjN4wTCL49yncAtRYf82GTb+iBYITBFM/
 UqQw6kvSwLW+VTAkhcNIwXuVZEo3Q+cjn/BnxiGzlsuPytKDAJ/QvNXPgllP0fAEsvkJPb6rqCi
 IM+W6WFucv6gIDfFHuPjPUhWFuqq81qljRCANyVzwYfeNbqwj8CoArzB7lquvSUtkZDk/M2BkBe
 23VIzYWkPF/GNBu8d50VZCJxZL+3avakz+XwWD2PtYFCh5MkJ1vGzZWSRe0DW2AW9g8E73FjhNP
 LAm+jCel9w/mrfh/t4JMlq4+w3bTAucna611v2Mba83qy/KfpZnlA5wzczMYXQt8HuN9sNFzN8B
 E9uy3J733gNkgZmaZFJRQjd7ErqvmRBHcxKLGL9ZnNBDNIFWbkmfCgcxz4x3owRtrj8LyMYEbRq
 BuvQARIcoQMNk6HqJJIk6HLelLLUg==
X-Received: by 2002:a17:902:f60c:b0:2cc:6329:b7ba with SMTP id
 d9443c01a7336-2d0ca7835a7mr452449495ad.16.1786303092485; 
 Sun, 09 Aug 2026 12:18:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8d6074sm36575413eec.12.2026.08.09.12.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 12:18:12 -0700 (PDT)
Date: Sun, 9 Aug 2026 12:18:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v4] app/testpmd: support runt frames in txonly
Message-ID: <20260809121808.6cdaabe6@phoenix.local>
In-Reply-To: <20260807061727.1687254-1-yangxingui@huawei.com>
References: <20260807061727.1687254-1-yangxingui@huawei.com>
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

On Fri, 7 Aug 2026 14:17:27 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> Allow setting transmit size to be a small value which has Ethernet
> header but no IP or UDP header, since control level protocols can be
> very short.
> 
> Checksum offloads are disabled when headers are incomplete.
> copy_buf_to_pkt_segs stops at the last segment to prevent OOB access.
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> Changes in v4:
> - Removed ultra-small frame support (< 14 bytes) per Stephen's review.
> ---

Still some issues reported by AI.
Also not sure why your email keeps ending up in Spam folder.

Reviewed v4 against main (c1a46b9). Applies cleanly, builds clean with
-Dwerror=true.

Error
-----

app/test-pmd/config.c: set_tx_pkt_segments() is shared with the flowgen
forwarding engine ("set txpkts" is documented as setting the length for
FLOWGEN too), and flowgen still assumes the old 42 byte minimum:

	unsigned pkt_size = tx_pkt_length - 4;	/* Adjust FCS */
	...
	pkt->data_len = pkt_size;
	ip_hdr->total_length = RTE_CPU_TO_BE_16(pkt_size - sizeof(*eth_hdr));
	udp_hdr->dgram_len = RTE_CPU_TO_BE_16(pkt_size - sizeof(*eth_hdr) -
					      sizeof(*udp_hdr));

With "set txpkts 14", pkt_size is 10. Both length fields underflow in
unsigned arithmetic and are truncated to 16 bits, and flowgen emits
10 byte frames - shorter than the Ethernet header this patch is trying
to guarantee. It also writes 42 bytes of header into an mbuf whose
data_len is 10.

Confirmed:

  dpdk-testpmd --vdev='net_pcap0,rx_iface=lo,tx_pcap=/tmp/fg.pcap' -- \
	--txpkts=14 --forward-mode=flowgen

  every captured frame is 10 bytes: 00010203040100010203

flowgen_begin() should reject tx_pkt_length below
sizeof(rte_ether_hdr) + sizeof(rte_ipv4_hdr) + sizeof(rte_udp_hdr) + 4,
the same way tx_only_begin() guards the split and multi-flow cases.

Warning
-------

doc/guides/testpmd_app_ug/testpmd_funcs.rst: the note listing what
cannot be combined with runt lengths omits "set txtimes".
tx_only_begin() additionally requires sizeof(struct tx_timestamp)
beyond the 42 byte header stack when timestamping is enabled, so runt
lengths fail with -EINVAL there as well.

Info
----

app/test-pmd/txonly.c: the l3_len clamp and the ol_flags masking are
recomputed per packet in the fast path, but the result is invariant.
TX_PKT_SPLIT_RND is already rejected when the first segment is short,
so pkt_len does not vary across packets. Both could be decided once in
tx_only_begin().

app/test-pmd/config.c: the first sentence of the rewritten comment is
still wrong - the loop rejects segments *larger* than
mbuf_data_size[0], not smaller. Worth fixing while touching it.

doc/guides/testpmd_app_ug/testpmd_funcs.rst: spelling out "14 bytes"
reads better than sizeof(struct rte_ether_hdr) in a user guide.
