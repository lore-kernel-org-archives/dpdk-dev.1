Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89EFF885D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B406040395;
	Tue, 28 Apr 2026 15:36:10 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id EEDBA402A3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 15:36:09 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c637089ccso3516939c88.1
 for <dev@dpdk.org>; Tue, 28 Apr 2026 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777383369;
 x=1777988169; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5YMeNNvSKdTzMidzoWdRdZNU/Nx4vt0iCHWmdIviQk=;
 b=OEMK67aIMNCBKFXwk16KEJcH2Ka1k3Z9nM0htaIbh8QzTSwur3MU0YTlRpO4BFqw65
 5VRlANK5jupUdr3bZQRe+EoxgmJDpKY0TQkxpvWCKxB+N65qtK9FHXeDMwO1cRhKtXNG
 rpVD453lKCTqZ1Fr5yl52IwOhksSjWZWQK6U2R2hDObEDiQMpsL9Jf7b3FTTDs+H0MG3
 ltA0L79XkjpwDJqhGf+oajqBCu/TkDTYvHiJr7uNsKPyzzqF9Aqsl/oeXgvKZmSu2UcU
 qyqpgsfNWxexvEqDH1Mkf5OEOmnmKmmUAbOw+8o1LjJb3M6tuoYUnMHJYC03bXSJzacU
 Ibsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777383369; x=1777988169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5YMeNNvSKdTzMidzoWdRdZNU/Nx4vt0iCHWmdIviQk=;
 b=F65G4LyMr2fZTToiuCuri2I8WDGmowfLAQr9WxJdsk668fI/vcotYG+aai4yy4MGIC
 tbgM9O0qvIgZcpL0bUDypQtak3pL3aW+LeHTX8AQ4Ic9LFv0xeis7ogckAibauDfYr05
 +V+RdeWlpLVIdjfvlEGofhdp52jfnMRbw/sYKKeLUh+Mg2spCIeAWTn9gXbmHKdZDOE9
 ss/Dt7hwqqt7pgKW9a/7t1UIbGNyMFWqSMGliy2LWVrPNvyxOh7ytFAsstNC1Qbrui8b
 bHEeABHQLlhd6U35I+/xHrIqV7tCdPobZz0RMB8MRfH0SxbiXxp2LdFcH10H5hQfi8Yp
 uEug==
X-Gm-Message-State: AOJu0Yw/gm3feBdBODrY6+/i4Ucg8OJemJdP/nAXg7FWFBL99QR+P8JB
 oq/lmezW9UodmMYTZ6PAZJuu7uHdQ0LpI3ZWCch4Eupz1LfQkF/Zyjg+lFkFgM9yX/M=
X-Gm-Gg: AeBDievANxcEWgqxHEtWnbAEy7l8eoitrIo9HU8uTiFIqU2vM/iw6W8y1SUP4aWS3Sg
 d0X22kqD+YnrEVRJbGEmmdDig9pEZZJ8piNnenXm7ddJKjaxiVS3OLLCXh4q7/cPC9osZ0+PMYP
 Q5t3EXK/JEHHySdwWv+OA8sfVD4WHShdGylCq5P5HPL59HQlYmss0u84Cm1ODz+b/aH8J8NWs3x
 rbCvn8gQ9jRyNnQ1o3ZLUDLPgjeBEBvlzb61lg2yqPinfia7TRR232GcVWmBByjolJiRQ56Folq
 cM4ZV2pUDpNgjs4r37AP1QuzX3nFeoHeqEaPFzw5UWp32VNsm5CRTftVRo1DM7NRR+rdw6d/5AO
 POsgwdVmafsd8ZptcFQGG8QZYXq5Lv1DM39tYG6V7CvEzBTTas5pSZZaogmfTJjNCZpIM/Op9N+
 d4NuR056sGfxKGoF3CgioyTXRzxDPY4ADDEWz8vOWrowdWjw==
X-Received: by 2002:a05:7022:670f:b0:12d:c039:65d1 with SMTP id
 a92af1059eb24-12ddd975e2amr1386701c88.1.1777383368506; 
 Tue, 28 Apr 2026 06:36:08 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9a64desm2896638c88.9.2026.04.28.06.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:36:08 -0700 (PDT)
Date: Tue, 28 Apr 2026 06:36:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v2] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260428063606.21b6ceb8@phoenix.local>
In-Reply-To: <20260427104152.1145165-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
 <20260427104152.1145165-2-rjarry@redhat.com>
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

On Mon, 27 Apr 2026 12:41:53 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
>=20
> This allows supporting stacked VLAN/QinQ tags and IPv6 extensions.
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

AI review spotted some things.
But it looks like more of a bug in rte_net_get_ptype

Now let me check the upstream source for the IPv6 header context:Found the =
bug. Let me verify the IPv6 payload_len semantics:That confirms the bug. `p=
ayload_len` is documented as "IP payload size, including ext. headers" =E2=
=80=94 exactly what I needed.

---

**Review of [PATCH dpdk v2] net/tap: use offsets provided by rte_net_get_pt=
ype**

Error:

The IPv6 packet length check double-counts extension header bytes.
`rte_ipv6_hdr.payload_len` is defined as "IP payload size, including
ext. headers" (rte_ip6.h:487), meaning it already includes extension
header bytes counted from just after the 40-byte fixed IPv6 header.
But `hlen->l3_len` for `RTE_PTYPE_L3_IPV6_EXT` is set by
`rte_net_get_ptype` to `40 + extension_headers_size` (rte_net.c:439).
Adding them together counts the extension bytes twice:

    if (hlen->l2_len + hlen->l3_len + rte_be_to_cpu_16(iph->payload_len) >
            rte_pktmbuf_data_len(mbuf))
        return;

For any IPv6 packet with extension headers this check will fire
spuriously, causing `tap_verify_csum` to return early without setting
checksum offload flags =E2=80=94 the very case this patch is trying to fix.

The pre-existing code was correct: it used
`sizeof(struct rte_ipv6_hdr)` (40) as the L3 term, leaving
`payload_len` to account for extensions. The fix is to keep that
same constant here:

    if (hlen->l2_len + sizeof(struct rte_ipv6_hdr) +
            rte_be_to_cpu_16(iph->payload_len) >
            rte_pktmbuf_data_len(mbuf))
        return;
