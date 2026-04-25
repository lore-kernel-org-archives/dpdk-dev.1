Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20804FF885C
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Apr 2026 08:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19B32402E9;
	Sat, 25 Apr 2026 10:40:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4D7EA402A0
 for <dev@dpdk.org>; Sat, 25 Apr 2026 10:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777106426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMLzU/CHCnzzw9XVdG271BIOcQBJrpN/+14NcUZIXmE=;
 b=cwCp9HmbODkJ4R4peIj5BIcN/ZLpIcXIYXvxQ5nv78i9QCQXigrenq9l8Hv45AujieURt5
 YXA3ys7u0UOVa5D0gMITtY6H+N/WVChWzVeoWpmpZd03XPDTk/ou4U+PTqC+wNPdtsVlLN
 aAj9g/EJ4fO/lQ4fKdQSndNtEHpn4qc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-LSM498f_Mp-Yn7z-88jxWw-1; Sat, 25 Apr 2026 04:40:24 -0400
X-MC-Unique: LSM498f_Mp-Yn7z-88jxWw-1
X-Mimecast-MFC-AGG-ID: LSM498f_Mp-Yn7z-88jxWw_1777106423
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38e7a752045so40350761fa.1
 for <dev@dpdk.org>; Sat, 25 Apr 2026 01:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777106422; x=1777711222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMLzU/CHCnzzw9XVdG271BIOcQBJrpN/+14NcUZIXmE=;
 b=aN+/cBaPLp9b34UqfI2PpTy6vwchJF+JPZ3nDkOCQ4PRX0CAZiqNvg82CPpnM4JT/2
 Txc6U8NCOufxLCtfCFAO0efESP54+t3M7tfAYlKFyoksY6uF8EKmmnrjS5F+prHm5Kwa
 acYdFPps1qMhVRMGoGcBFtUNGoWPBDbiXUlYLTc1Tr8mX07fCmpLXjsjUcAz5mcPvNNK
 q+jqWUAtr6pJYM/wwE6pM8jz7g4F9ZkRt+4mkLsD767GSrcTMsHjfk9SDvStPV5GD8T1
 SJs8evtYcySg8Mvd14SUr6phzsJGXP6RF4fmk2KHhp69nkLN1ndxreZYQCCaVGvrHJpF
 NhlQ==
X-Gm-Message-State: AOJu0YwCta03ZxhvBykkRwIwpMXRJ7QgkRWFwKlo2b6LiVBCke5wULI2
 8hyQEeoi/o35h/vqQ+QrIjrfL9Y2TQJQoGTX4om+Wg3jInBUSbIThdnTNliaxmbYMOjP+W8LTQK
 SbOQVX6HQMNBWgEZgnFikFq4EokkkPa1hhpi4oCjD8wZ+j4KbSWfwFzoOYqBNwCfbMpaDV7Ou8G
 Ml8VYm6767WFXGPScUUMU=
X-Gm-Gg: AeBDiet0Y74aU/UBh6tVCSQgmJJp9rrY9vLfytOh0JuGYo/O3+HLGhhf9ttkHDSNXRZ
 3toi352RjYGU07hcETDaIeiHlfW2V669mQVozHmYq7x1kaOK5T69T5WSl1M+buGolEVrLCFupCq
 AAJVRPKCrvkEAYp9R8Y92pwzW5igVnni2kga6r0tAy/aseGqUFHc4Xp4BsnSi5WE9ZVKlNy8wPF
 CUbkbuVL7Iz5cBuCGkpUFUFGp6VGvE/AWsfcXINunTfz6XLRlvtQME9lVVOnda66q8Hgw15id6z
 2Qxx
X-Received: by 2002:a05:651c:54f:b0:38e:b774:e1a0 with SMTP id
 38308e7fff4ca-38ec7823ffemr108632091fa.15.1777106422540; 
 Sat, 25 Apr 2026 01:40:22 -0700 (PDT)
X-Received: by 2002:a05:651c:54f:b0:38e:b774:e1a0 with SMTP id
 38308e7fff4ca-38ec7823ffemr108631991fa.15.1777106422058; Sat, 25 Apr 2026
 01:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260423112458.865674-1-rjarry@redhat.com>
In-Reply-To: <20260423112458.865674-1-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 25 Apr 2026 10:40:10 +0200
X-Gm-Features: AQROBzAHWf_R6vM5X_U-7FyddvUuty3z-4xDipUiNB70kMDKCLjRLIKs_rbXkxE
Message-ID: <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, Kevin Traynor <ktraynor@redhat.com>, 
 Luca Boccassi <bluca@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pF0U7p38pfA_7CTjYSoM8bR9udjM_HsY9La9StyhEHk_1777106423
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

On Thu, 23 Apr 2026 at 13:25, Robin Jarry <rjarry@redhat.com> wrote:
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index 458b4814a9c9..a871318b21c2 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -357,12 +357,14 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>                 const struct rte_vlan_hdr *vh;
>                 struct rte_vlan_hdr vh_copy;
>
> +               if (vlan_depth == 0) {
> +                       pkt_type =
> +                               proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
> +                                        RTE_PTYPE_L2_ETHER_VLAN :
> +                                        RTE_PTYPE_L2_ETHER_QINQ;
> +               }

This code is becoming too complex.
The original usecase with more than 2 stacked vlan is a bit strange,
but the max depth limit seems just arbitrary (why 8?).
We have clear boundaries, with the size of the packet (see below,
check on vh == NULL).

The offending commit also allows stacking mpls on top of vlan, without
mentioning it.
I think we want this behavior, but still was it intended?

In the end, reverting the previous fix then just advancing off and
breaking once proto is not a vlan/qinq type gives a much simpler fix
when compared to v25.11.

(ignoring indent changes with -w)

$ git diff -w v25.11 lib/net/rte_net.c
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index c70b57fdc0..f58d699c83 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -349,30 +349,28 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
        if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
                goto l3; /* fast path if packet is IPv4 */

-       if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
+       if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+                       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
                const struct rte_vlan_hdr *vh;
                struct rte_vlan_hdr vh_copy;

+               if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
                        pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
+               else
+                       pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
+
+               do {
                        vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
                        if (unlikely(vh == NULL))
                                return pkt_type;
                        off += sizeof(*vh);
                        hdr_lens->l2_len += sizeof(*vh);
                        proto = vh->eth_proto;
-       } else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
-               const struct rte_vlan_hdr *vh;
-               struct rte_vlan_hdr vh_copy;
+               } while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+                               proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ));
+       }

-               pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
-               vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
-                       &vh_copy);
-               if (unlikely(vh == NULL))
-                       return pkt_type;
-               off += 2 * sizeof(*vh);
-               hdr_lens->l2_len += 2 * sizeof(*vh);
-               proto = vh->eth_proto;
-       } else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
+       if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
                (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
                unsigned int i;
                const struct rte_mpls_hdr *mh;


This is untested, but what do you think?


-- 
David Marchand

