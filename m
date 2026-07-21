Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F2C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 11:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C8B40294;
	Tue, 21 Jul 2026 13:49:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7F5A440289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 13:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784634583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35FKd2r0oqXkVsE//NW2DMJs0YGwWm/mVVjuYUMmp7s=;
 b=NO1mcRpmaudapu1aBdBUSFFNhCXNcDzz9rVBuuYxOy2Hocc4qMxyrrJ3xCdMtPhl5HBSjQ
 tkPI5qSNLLMj+YYIoEt8vS4Zlk1zllDG02LIWkznvLV0k2J/isj+9ZkpLeQR4vRLOegx6F
 ZV2VZd+WF9vffkAhupACzSEwZTi6fyE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-KVOEMBGmPyOs5p84KnT7ig-1; Tue, 21 Jul 2026 07:49:41 -0400
X-MC-Unique: KVOEMBGmPyOs5p84KnT7ig-1
X-Mimecast-MFC-AGG-ID: KVOEMBGmPyOs5p84KnT7ig_1784634580
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeba93926fso5241498e87.1
 for <dev@dpdk.org>; Tue, 21 Jul 2026 04:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634580; x=1785239380;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=35FKd2r0oqXkVsE//NW2DMJs0YGwWm/mVVjuYUMmp7s=;
 b=ctqNVJ8jXlIT20/7WCYTxWTYQljdyiA5YC46gkGUtNP4AvEO3jAfkrgtacBWSpionY
 JrRnDb7GnEJmSC5oAdhkAa9wNjmPbNVGJXgEk5Hh3grca5hJDbPEgdkCfNxxWYsq+v1b
 83MNp0//BVq9ml60yxOQrgxXOg9BqqwA6Rn5pZvnE3s4apRvQuDOmLeGDnlzqk8phTVb
 6+epjEBY8/ycwy7vZvR+2BAbsa6gzos9co422qkz3hCtpinP1noQPBPdxBqoM9HBLBvy
 abPZ+W7sE1m+8vKM0RIMM6I6NyZaceHreQIH1L0fbTsGiYwqYVT4SD07qFAePtqMK1PG
 ckYA==
X-Gm-Message-State: AOJu0YxX6zC4O9qWTIz1aAA3MLnGI/1CsDU2MJbkrlFuxzXEvWZbLBzh
 2ZKaE2maMJ2Iwvy+IDAVkWsShhD11ijdnwVV5ng+5BhaehEpjqy/v9y0Ukvi+YR/OcdkIEfsncz
 p9PbzAqblyp7XmbMF/5EmSYxC5L2vBiQdTTxo+MrU0bHbN7RiL82UOYfRXZwP+4fljReHRDq9pO
 FiTVXRsdl109N6/+bcMzE=
X-Gm-Gg: AR+sD10lHLD1xr45r/8FaLEtqzNjkBrBSf7HDRTFQ3JnvADndCWdEt9M6FRQFNia6uH
 7JfJF2XCvk/fPbAx3/qEP+0+aFw6kruKGr8tD5efBv6WBDiX4cTQzYJeVPNrKSPmPvSj4RyKkRx
 Ao3t2CLoBYqtKYFS0++4NspoucOvKfivfgFV2PNXkBZHzyWRD7baxWLb2dSTAU7DKLoUtgnHqSM
 /p8spu4rnR5+cPBO40FepxSmYjUinRHbIjQ7wiX3ebQ4Z2o
X-Received: by 2002:a05:6512:6699:20b0:5b0:190a:5b63 with SMTP id
 2adb3069b0e04-5b28f85c936mr2059219e87.15.1784634579677; 
 Tue, 21 Jul 2026 04:49:39 -0700 (PDT)
X-Received: by 2002:a05:6512:6699:20b0:5b0:190a:5b63 with SMTP id
 2adb3069b0e04-5b28f85c936mr2059213e87.15.1784634579149; Tue, 21 Jul 2026
 04:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260717090121.1859773-2-rjarry@redhat.com>
In-Reply-To: <20260717090121.1859773-2-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 21 Jul 2026 13:49:27 +0200
X-Gm-Features: AUfX_mwOJ8Ft8wqxLB4rbHel-_SgIP6ZMd_gwmCh9HIh00B2veOqfhOGCupbcVU
Message-ID: <CAJFAV8zHCTRKMf0xhD4RRY+3kXh_g-6Yk=j4JKBd8NQ+Ohh2BA@mail.gmail.com>
Subject: Re: [PATCH dpdk] doc: announce rte_graph ABI changes for 26.11
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qui_VIdR4uZDmlAp7qY7Y0iAPLdWPynW5lkXzhDKbuk_1784634580
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

On Fri, 17 Jul 2026 at 11:01, Robin Jarry <rjarry@redhat.com> wrote:
>
> The graph library internal scheduling will change from a circular
> buffer to a topological bitmap. This affects struct rte_graph and
> struct rte_node layouts.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

I would prefer those (internal) details get hidden entirely, but I
guess this will affect performance.
Maybe something to rediscuss during 26.11, but for now:

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

