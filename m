Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F4C531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 16:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E07740269;
	Sun, 26 Jul 2026 18:37:07 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 68A8740150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 18:37:05 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-ca97d139d8dso1084524a12.2
 for <dev@dpdk.org>; Sun, 26 Jul 2026 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785083824;
 x=1785688624; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BZ1SKjVcW6xGniTwERYjEX8H6uV4eoMKnMEPjheDBB8=;
 b=mUdccF8SuXxFdMNlgtv+HKleq0gYh5CsUtiZTho3UbFThSEzcIwTzR2IUnvGEJgirp
 9qBUBX0F+ITBAjNUUWI8RrS4jNpGFDNY1icKoDQcNj1I739a5qfXJAcxfkxluzbZE3CJ
 u3mraWAR4C464SqH1jfeCmcn1ggdHd7XxItOtqsEW7WwwpBt+S7N107//IpGXH2Rgibg
 BZQHoJgtNOyeUHh8fIlXf1RWnUgJwfcH9dnGR2/zRdLkN+wvfE0Ctcc3+HGixaz2a4/p
 7bJCp/qPrBQBhA+oc5q5zBTgta45s7vkk3V3h1g04GdDhey6PH/AYLWmatDUmYspdWNv
 u49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785083824; x=1785688624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BZ1SKjVcW6xGniTwERYjEX8H6uV4eoMKnMEPjheDBB8=;
 b=tDwIDXGgwEwvKI+QpDeafM6w4NlrQbTXwvc2mYFvBOZ9gw8/9WQU+4uZozlBEWHUke
 tb0vnNgR1jW6ND3rcqYnsCrDy5tvyJQtC5E57JKQ3CMzyzzph3I4pIu+zsO+JqvnEjZv
 xIlWrUyKzjpJuE44yOvvHHIIvAjLHVNMDEwl26cHlWvxXusKAUmV2qA8aMDwOLny3ttp
 2p7PkwceWav6bZKtxI2vNIrrS1sCcT+20diHywLOBraCWtBoycfh6nTs/1hd0gdV013K
 DbbofR6KCUcaQa5f64AZS6gjovtVNLYIxPZQcPibGjSGy/Bi5EbW1+lj08ItDgZd5dLV
 eIyg==
X-Gm-Message-State: AOJu0YzLltcIU8X9IQk4/ivGkZAX0eWObOgG6MeWFsqQAmV9x5lFAPhe
 ejWvfLiW/PX/Glj32vEZ0s6ixUYJyCXUmY10APGCyjZJ2wEuS8kXUywEVv+LNlG58nU=
X-Gm-Gg: AR+sD10K6/hBm5C+LxtbSlJgr+matjovz7MXgc/5nYUAMzMNuaReqVtE6rEOjkLPcYp
 bzifWXCK0yGAuiwGcOVU+A2Awhs0EHWkEr80cuV8+CgiNE9qR7fuzmUw78iMu7q/MzkTOqgKR7w
 kV4GVLAb37m/Y6D8o80F2RLM2qPrRppk2DW4r5hHT1Z1xZHSmxAPZFDoWXsm7BPwGv77qOzr2OK
 QlIAj3wsRLTv1WTZYWUs2YqKvKyaXfDKo3NTFGVFO/0LCVeylIpIbmvhxPbCDBIIX+Q03NPDhoM
 iRrjb+qpOx5GbdPIO4LJiOlGfNNfw09K9bshum+CYPJnmSXzm0D2IAyBxcYebWmn+QmyMFXjWJ5
 BdEuf9P57fWQenMp5mOJyln2c++1MsnN2FqsTrJ/Ux1gV3i+TEKGqMQMw1izqJuaJtSCqtxkUTR
 7OCbliU3yPfopI09ygdQcesw18wXrdHXtBAsddY1JE+9I=
X-Received: by 2002:a05:6a21:a346:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3c67d9b40b6mr5590657637.5.1785083824211; 
 Sun, 26 Jul 2026 09:37:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e127asm36650224eec.2.2026.07.26.09.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 09:37:03 -0700 (PDT)
Date: Sun, 26 Jul 2026 09:37:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [PATCH v2] net/dpaa2: hash inner IP for tunnelled traffic
Message-ID: <20260726093700.39e9b9ab@phoenix.local>
In-Reply-To: <20260723093540.1839619-1-maxime@leroys.fr>
References: <20260720133436.869334-1-maxime@leroys.fr>
 <20260723093540.1839619-1-maxime@leroys.fr>
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

On Thu, 23 Jul 2026 11:35:40 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> The RSS key only extracted the outer IP header. Tunnelled traffic whose
> outer headers are fixed then carries no entropy for the hash, so every
> flow lands on a single Rx queue.
> 
> Extract both the outer IP (header index 0) and the innermost IP
> instance (HDR_INDEX_LAST). Plain frames keep being hashed on their only
> IP header; the inner extract resolves to nothing and adds no entropy.
> Tunnelled frames are also hashed on their inner IP and spread across the
> Rx queues.
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

More detailed AI review

Warning: RSS key size likely exceeds the DPNI key limit

drivers/net/dpaa2/base/dpaa2_hw_dpni.c

Doubling the IP extracts doubles the generated key, not just the
extract count.  The driver's own accounting treats a NET_PROT_IP
full-field address extract as 16 bytes (NH_FLD_IPV6_ADDR_SIZE, see
dpaa2_flow_add_ipaddr_extract_rule() in dpaa2_flow.c), so:

    before:  16 + 16 + 1                = 33 bytes  (+4 with L4 = 37)
    after:   2 * (16 + 16 + 1)          = 66 bytes  (+4 with L4 = 70)

DPNI_MAX_KEY_SIZE is 56, and dpni_attr.fs_key_size is documented as
"Size, in bytes, of the flow steering look-up key.  Defining a key
larger than this when composing the hash + FS key will result in an
error."  The PMD never reads fs_key_size and there is no size check
anywhere on this path, so the first sign of trouble would be
dpni_set_rx_hash_dist() failing and rte_eth_dev_configure() returning
an error for a plain RTE_ETH_RSS_IP request that works today.

Has this been tested on hardware with RTE_ETH_RSS_IP (and IP|TCP|UDP)?
If MC accepts it, please say so in the commit message, because the
arithmetic says it should not.  If the limit is real, the extract set
needs to shrink -- dropping NH_FLD_IP_PROTO, or extracting only the
inner address pair, would be candidates.

Warning: the "inner extract resolves to nothing" claim needs backing

Both the commit message and the new comment assert that on a plain
frame the HDR_INDEX_LAST extract resolves to nothing and contributes no
entropy.  The MC header documents hdr_index as "used for protocols that
may have more than a single header, 0 indicates an outer header" with
NET_PROT_IP taking (0, HDR_INDEX_LAST).  The natural reading is that
for a single-IP frame the last header *is* the outer one, so index 0
and HDR_INDEX_LAST select the same header and the fields are extracted
twice.  That is harmless for distribution but it is not what the patch
says, and it changes the key size and hash values for every existing
non-tunnelled user.

Please confirm the actual behaviour with NXP and describe it
accurately, one way or the other.  This also feeds directly into the
key-size question above.

Info: duplicate constant

+#define DPAA2_DIST_HDR_INDEX_LAST 0xff

mc/fsl_net.h already carries LAST_HDR_INDEX (0xFFFFFFFF), truncated to
0xff by the uint8_t hdr_index field.  Two differently-named constants
for the same hardware encoding in one driver is confusing.  Either
reuse the existing one with an explicit cast, or add a comment saying
this is LAST_HDR_INDEX narrowed to the 8-bit command field.

Info: placement

The #define sits between two function definitions.  Move it up with the
other file-scope definitions, or into dpaa2_ethdev.h next to the
related driver constants.
