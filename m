Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FFF54AD9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D41402BE;
	Tue, 24 Mar 2026 17:47:38 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id C3B9E4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:47:36 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso1700730eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774370856;
 x=1774975656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfSmS5Siorjc7+SKNGnzfP1cZE35Fr3xh5+sUFXSf60=;
 b=AEUPkwowsj/d03CdXEXJcmWe/fT/6g/GbvUhByXAPVBJqJ9DXCLmxA7IlFBPeh1+Ny
 wHitFmdd7ljp16QupTv2w+PaoNtluhSwooBBfs/ew+87Uu7+2MKQANb1IpZ0r9ibPgwz
 m3yTzk2Q3vboVHljf0DtfDC7LzrXANDUJorveiH6cQ74TlYIlr6B2SswuX3XLR6ALkJb
 puxwqOnRWz3Raq85lKOKlW65E43nNTh+Qo+pHrDZATmYAmEZlBbwuOoruBaUP+ohr5+a
 miyseyakaeU+srAzFgHbtcBaEURT3Dg430ZuKb/vAfOkRPnNhqGD+kIfENhgwe8wgFOe
 3E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774370856; x=1774975656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfSmS5Siorjc7+SKNGnzfP1cZE35Fr3xh5+sUFXSf60=;
 b=iKopyccEKNBHGLsC4a6kxEGYbtggHUT4JovHj41PAOGpPbAUQMv9na9e7jGGpKjCrj
 qBdpN7N/i9HCXqxHJeFyzA0pdX4qG5rWU2HJTIK4P0SmfN4JrSbgpe0PhvTsOaB7/HLn
 i9xCKT8jA/0QdolEinzZgj0F9viRc/FjiNm6bBKQ5LIqXqKtoNyy1Sjwt3dSB9my+WTC
 a1fxCU88EdZt4AnX+Gegs+rrYteJlGWQ7DUJaVBFKwEl4lnFJVMrcKQxdw06woyAj330
 2T5IW3yKYDIaqSdrqhMuq2sjYaFWEi9tTx+1GE6N/255jqh7bv6A4wgkzwqb7jInicGK
 iu7Q==
X-Gm-Message-State: AOJu0YwDtHI1nIGdEmz1x1E/I3gXG1U40ArIfxU0STyQ6QhhDgnvyXlO
 /Tzu5F2i+Vf4y2gCO6XdWFjQnaUdBVQIYdvfNwCsccVFL/Om4Y5PAXA5vNLH9Vj1vnw=
X-Gm-Gg: ATEYQzxDcElBxkTFiKWbNsrmEOB5SmZ56BYo/ojA6pD04Sa8P+hbDRzc4MUmI+jhvvv
 LeieLSmgxNEP7LAU4xo5d5jjz3uny/bizwcQOaf+nhSxv/5CQ2ebMrNmr29kU6mOjWynb7LD2cm
 advBtRsqKvEQ8zCs+8Xp3K7I8U/S0d8Mkb68VxRIzHRq3nnBKZaH8UaODPOD6lxjmVLbB5Z+AEs
 8Knd9i2QGl8u/+q79jsSOQsyJfzfOLhTZpLkziN87LoF1B3upqh34VKfv9xAdRBL9ho3PheCOAD
 VXHy1lgUWNBVNi0BbB2+mV42CACtQ9+tpkbCaNYr262r3FvvML1JsL+lO59ag/5OrFDwO7ley1r
 pUGV5S5zb4M2uK0aSPKqwHj+BJF6Plr2vFKY9Sq1XNu+1VS8tjeGnRsZybNq7Ksn+FormSWough
 IOcgxb5+TS4hM2GAw6NGvzTKEkJCfRAsIQH4k=
X-Received: by 2002:a05:7301:168b:b0:2c0:dc7e:ed17 with SMTP id
 5a478bee46e88-2c15d34dcefmr36947eec.10.1774370855418; 
 Tue, 24 Mar 2026 09:47:35 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17a7c1sm15897994eec.7.2026.03.24.09.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:47:35 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:47:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v20 12/25] net/pcap: support VLAN strip and insert offloads
Message-ID: <20260324094729.1515e8f1@phoenix.local>
In-Reply-To: <abgOCyUiSMKZ9njL@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-13-stephen@networkplumber.org>
 <abgOCyUiSMKZ9njL@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 16 Mar 2026 14:04:59 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Are we sure this is the correct way to do this? To behave like a normal NIC
> the Tx VLAN tag should be inserted in the Tx function, rather than tx
> prepare should it not? There is no guarantee apps will call tx_prepare
> before Tx.
> 
> /Bruce

I wasn't sure, but copied what virtio PMD was doing.
If application is using VLAN's on virtio it would need to call prepare.

uint16_t
virtio_xmit_pkts_prepare(void *tx_queue __rte_unused, struct rte_mbuf **tx_pkts,
			uint16_t nb_pkts)
{
	uint16_t nb_tx;
	int error;

	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
		struct rte_mbuf *m = tx_pkts[nb_tx];

...
		/* Do VLAN tag insertion */
		if (unlikely(m->ol_flags & RTE_MBUF_F_TX_VLAN)) {
			error = rte_vlan_insert(&m);
			/* rte_vlan_insert() may change pointer
			 * even in the case of failure
			 */
			tx_pkts[nb_tx] = m;

			if (unlikely(error)) {
				rte_errno = -error;
				break;
			}
		}
