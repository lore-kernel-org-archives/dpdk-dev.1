Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650B606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LWHWDYRG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6844C40270;
	Tue, 20 Oct 2026 09:40:22 +0200 (CEST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mails.dpdk.org (Postfix) with ESMTP id 2B0F040297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:20:06 +0200 (CEST)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8ab43f7f5faso33467037b3.2
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792441205; x=1793046005; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=516OAUmDBSMnahtE4d7HgnPysz9FITBKicQTSHhcdXA=;
 b=LWHWDYRGPEwflhRHCteoL5qm2ZFcFB3iCoIDd/pmUOmEgGf/gm5Yz5qIUFK4JnYTX1
 xwWOJkdZaQGaBUN1qr4nXO6OjMg/4jJefDi9ElGuCpuRS1ItHYc7p4/xfqUqla5EF6O3
 XKNSlqbVEnbav5nwQ5JntIgsw6j7PHF82D3n3Bokpd8B6TdwmDP/r875lsUPdmhvOToZ
 CXpFvGMQEPIsim39BchQY60VVEeVAPf+5+XkpOLdb0aEZNSE4cRpri9LKmVih6zZF9xa
 bpxejdsmN1RPTohjK7JVMXA/DsyU0qgx4A5WrLH22fR63wPIQgZxbcOG6SXnJW096rUV
 uTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441205; x=1793046005;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=516OAUmDBSMnahtE4d7HgnPysz9FITBKicQTSHhcdXA=;
 b=jL8+Hx9/H8pIWmUY9D+g5iwzbajcHA/9diZoapR/YTOyAeb1GyMTnILZ1hXod6FdbH
 ARJIBJM4tJrzURKU6qP+pXPUiaIaG0F8ekBXMa0Jf2rbi7hT7yoQZ+Z6hdh4576BsL6f
 D/Vh9nUzhIb9/CT7h9cgIZO8/LuBTHx2EHRGQ/3gJb5bgWkCeSCP9ockObldkniLAWBI
 nVlCiByE4t50td15GLjlT9LrT6EgLSlsWKi0vMj4igk6MNsVJl4YLoFceHE9WMMZNEP/
 3l67MtIjHC9bK7sm5Ia68KKQe3z1+mkZG867oLEX6p0kxOpz91G2Uk++yq2zTcuQThCx
 9rEw==
X-Gm-Message-State: AFq9FYJ9XIi/dLPRhutpYXlnh6ycyEyxafDIlfXDPO5R8mMDFe1ANryu
 97SuZZbzuQxAICFlngAawVwidWX5eT3LLAfOzYw4ZClJrMIv0rrLQXf5oJQ9L1ccO8IuPclwBFy
 +zYbGXMqSC5R07kKhLvLKyYXi3/vjXHgy+X4ugwTyC/zcg3TDz0TQn2b0jvkxUMbz2Ky0kgkKES
 lRLW1WDfWHiQ43xT89A0Te+Fs+mA7G
X-Received: from yxns16.prod.google.com ([2002:a53:c210:0:b0:676:8341:3a38])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:43d7:b0:679:b8b7:9051
 with SMTP id 956f58d0204a3-679ca7f846cmr1378171d50.25.1792441205106; Mon, 19
 Oct 2026 13:20:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:20:02 -0400
In-Reply-To: <20261019022824.189319-1-rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019022824.189319-1-rnwolfe@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <cover.1792439728.git.rnwolfe@google.com>
Subject: [PATCH v2 0/2] net/gve: Rx scatter for GQI
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: joshwash@google.com, stephen@networkplumber.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:40:21 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GQI receives a frame larger than one Rx buffer as a chain of mbufs, but
the driver doesn't report RTE_ETH_RX_OFFLOAD_SCATTER, and it chains
whether or not the application enabled it. 1/2 reports SCATTER for GQI
so an application that gates multi-segment receive on the capability,
such as VPP, can turn it on. 2/2 refuses an Rx queue setup or an MTU
change that would need scatter when the application hasn't enabled it.

Both patches change only the GQI queue format. DQO has a related
problem that this series leaves alone: its Rx path ignores
end_of_packet, so with Rx buffers smaller than the frame each buffer
is delivered as its own packet. DQO should either chain those buffers
or refuse that configuration too; that is left for a follow-up.

One more gap 2/2 doesn't close: the check reads dev->data->mtu, but gve
never pushes that value to the device. rte_eth_dev_configure() sets it
without calling mtu_set, so an application that never calls
rte_eth_dev_set_mtu() passes the check at 1500 while the device keeps
the MTU from its device descriptor, and on a jumbo VPC it can still get
chained frames. Applying dev->data->mtu at configure or start would fix
that but changes behavior and needs hardware to test, so it is left for
the same follow-up.

v2:
- add 2/2 to refuse MTUs that need scatter when it isn't enabled
  (Stephen)
- correct the DQO statement in 1/2

Ryan Wolfe (2):
  net/gve: advertise Rx scatter in GQI queue format
  net/gve: refuse an MTU that needs Rx scatter when it is off

 .mailmap                         |  1 +
 doc/guides/nics/features/gve.ini |  1 +
 drivers/net/gve/gve_ethdev.c     | 23 +++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h     |  9 +++++++++
 drivers/net/gve/gve_rx.c         | 31 +++++++++++++++++++++++++------
 5 files changed, 59 insertions(+), 6 deletions(-)

-- 
2.56.0.218.g1ec904b173-goog

