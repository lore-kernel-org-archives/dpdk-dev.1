Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438ED606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=CQjrfIIq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3392840297;
	Thu, 12 Nov 2026 07:29:48 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id D8AB84026A;
 Thu, 12 Nov 2026 07:29:46 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 1BF3B26BC3;
 Thu, 12 Nov 2026 11:29:46 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 1922326BC0;
 Thu, 12 Nov 2026 11:29:45 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 1922326BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794464985; bh=eRfot+82jRX+rn6R5avLY3QctzJYoYfnq40eso0XS08=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CQjrfIIqNuqiiLm1c4+i7ICJzhDCwlJLU8TBDDS9fx8jQhOp9WRB7iy/RuYoXQbYj
 KVil9yPp+YRGVU4+iccHVcbpdWmRz28klsa5ZM2VI6fHTjRCmLSjQoHw3lkWJHQjE7
 KMTQ8s80uFBNAtWtOwcAoShF85Vl945aMArKmGcuzTefT1W+GlQ9s0mrmTJW9Bu9f6
 FBd9dN72J8rUcxA/mwbQoyiSvdwQAXs6ehPAu5Mv30E1QTwIOLT4kDXS/yvCsd/4eA
 4u30CgkXQJgfymw6lsoRsuRZxcmbVDrkLDFYq53x2Fl7EthryeeqXIcfeTi7HKF6C8
 9xM8UVHYDxM8w==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	dmitry.kozliuk@gmail.com,
	stable@dpdk.org
Subject: Re: [PATCH v2] acl: reject rules with inverted range
Date: Thu, 12 Nov 2026 11:29:36 +0500
Message-ID: <20261112062936.16000-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f350e15d-2040-4a99-b7a0-1c3391cedecc@yandex.ru>
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
 <20261111073041.38712-1-a.mokrushin@ideco.ru>
 <f350e15d-2040-4a99-b7a0-1c3391cedecc@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Konstantin,

> Why not check rules range in rte_acl_add_rules()->acl_check_rule()?

Because at that point we don't know which fields are RANGE ones:
rte_acl_param carries only rule_size, and field definitions arrive
with rte_acl_config in rte_acl_build() (ctx->config is filled there).
The same set of rules can also be built with different configs,
so a field that is RANGE in one build may be MASK/BITMASK in another,
where value > mask_range is perfectly valid.

That's why v2 validates them in acl_check_bld_param(), once per
rte_acl_build(), as Dmitry suggested.

If you'd prefer, I can add a sentence about it to the commit message.

Andrey

