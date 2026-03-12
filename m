Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A77106ACC1
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E915440613;
	Thu, 12 Mar 2026 17:06:23 +0100 (CET)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id EE967402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:06:22 +0100 (CET)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-4138136f02eso907744fac.2
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773331582;
 x=1773936382; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvX4XsQKFVc2F+4/9dxYNNFKNoLaEwRL/RM+QLmILDI=;
 b=04J+a2unSXlFMwMOOqV5HnnDu9mgoYTFEwX7cNTcmPm7lJlbsimtIBZVJ47YbdywkR
 SGIpIbTnfZzw5zvFfpe5Xz01/0rKmScRqCqB02KPoTk1Tml/XwreMFLCqH7LGtHlwypm
 sOYpSgBpMfi9na7D0jsf8cGXhLOAHzkl90vsP+fHGpoFhqIjl2eHoayqTXTyl143cn/W
 7eJHAkIU+drzOIV3Dr7dVJ0pw40gdG84So3aPgpcu0gp9PunFQ1ZuYrrHrEYadR1gbld
 8FPD2FP0FDUdSfIgR9wKtl3CcDfsUlAnZFZ3UlANq2Ipf4lTuTn4wA+SzZMTBYV2Qh4J
 gjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331582; x=1773936382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UvX4XsQKFVc2F+4/9dxYNNFKNoLaEwRL/RM+QLmILDI=;
 b=XAHjq/NJ0J1AXb0djaqgkbGmQCfE1kI4pFHqSGtzkWUDNqngmXcgTaOHXdf59dHYuN
 Py2HeF2pG1y/ib66wOzBoTGyIy9maABFhXQgWXQujI21NV63RfTrcV0+q2vjPfuACCZs
 Nlu18lNZwLEMZA/TVMNSTroJn5GUFXj+xEsXO2FB1YGvUxxTGMJuss2zcCVtOcim7JQr
 z6fIy224WcylVjApocZJ9w7m/y9UaUxmPjaZ67CaBTrEAPvf8CXyO1BzgdQNOrvbY+3M
 O+5x38W1pNmY77D6EsLM5w2abkgig7ctwGuWxqi7uc0xfxxjn7GCLUy4eh+E+OF498DK
 dMFA==
X-Gm-Message-State: AOJu0YxvSHU13Idid1iuYEq1RZyR316uWqCwOusqA0WbYCrvIbiHFoWq
 mcF4IHvwtOZDeVdSn9h8jq/VMcCeTfNKLp2fs3d4zXa2GdJRemVGb0q/+gB6uYWXTbc=
X-Gm-Gg: ATEYQzwEmZzoqosEPg9nsrQBVrMneGUMN9u59TD2/KKcGOfryKflkAnktZkZhTnYN9B
 GMkbA0euLsvQCPtgcUlYJin7e3dapBjPKA8nqkkXe63HOdyIIAn4ycQETc1zDyP+qT/nck92vg9
 cEcZlVtISdT7WCP71WpUFZTfEbZsXxcifOGl+VGGdU7UwLUKFEuM6I9ZpEAeMZODZGoKFYwIKUi
 peVN9ZIcS8qFLROu1v+G+hOL2w5p7TdEFeRBZEUk3i1CvyEWiDGyD32y3Lw9Z8nhndQ1PVrpSAw
 bzqIHuNEVwZ+khsNy8G2Jmxt7cWvg/3aW4Ym38nte4U+sr1eDSbl+RFTjYfVVHjHKF8QybZ2oRv
 inlyA4p+/og0oKf0TtYUAm2eW+Q8nBL8RN6FbT1XvyrM66VPB3j2R8/+Zfj6fsmKm1vB8aklbvZ
 Dt8B5LX2srrjOY7ngMbwZvDn6zJgh1Di+h5Iw=
X-Received: by 2002:a05:6870:b01b:b0:417:69c2:4026 with SMTP id
 586e51a60fabf-4177c8c95eemr3302935fac.19.1773331582006; 
 Thu, 12 Mar 2026 09:06:22 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e94b4sm5121238fac.11.2026.03.12.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:06:21 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:06:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>, <robin.l.lin@ericsson.com>
Subject: Re: [PATCH v3] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Message-ID: <20260312090618.1d8c081d@phoenix.local>
In-Reply-To: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
References: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
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

On Thu, 12 Mar 2026 08:34:03 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Enable jumbo frame reception with default mbuf data room size by
> chaining multiple mbufs when packet exceeds single mbuf tailroom.
> 
> Scatter Rx is only enabled when RTE_ETH_RX_OFFLOAD_SCATTER is
> requested. Packets are dropped if they exceed single mbuf size
> and scatter is not enabled, or if mbuf allocation fails during
> chaining. Error counter rx_dropped_pkts tracks all drops.
> 
> This allows receiving 9KB jumbo frames using standard 2KB mbufs,
> chaining ~5 segments per jumbo packet.
> ---

Scatter is good, but additional checks are necessary to validate
mbuf pool and buffer constraints. See virtio configure for example.

bool
virtio_rx_check_scatter(uint16_t max_rx_pkt_len, uint16_t rx_buf_size,
			bool rx_scatter_enabled, const char **error)
{
	if (!rx_scatter_enabled && max_rx_pkt_len > rx_buf_size) {
		*error = "Rx scatter is disabled and RxQ mbuf pool object size is too small";
		return false;
	}

	return true;
}
