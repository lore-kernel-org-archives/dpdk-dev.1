Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC3606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=axI2R712
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F376402A2;
	Thu, 12 Nov 2026 10:54:42 +0100 (CET)
Received: from forward503d.mail.yandex.net (forward503d.mail.yandex.net
 [31.44.14.19]) by mails.dpdk.org (Postfix) with ESMTPS id 619FA40E16;
 Thu, 12 Nov 2026 10:54:41 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-88
 (mail-nwsmtp-smtp-production-main-88.yp-c.yandex.net)
 by forward503d.mail.yandex.net (postfix) with ESMTPS id 05FD7100062;
 Thu, 12 Nov 2026 12:54:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88 with ESMTPSA id
 asQUDRbfR8c0-oRGfrpCL; Thu, 12 Nov 2026 12:54:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794477278; bh=rp5RU6UH6RA43vRS0lapV+JmGXdZp6yWPRWPgIHb1YE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=axI2R712+0ecEYelLrQXgsKhKJOWLVYa+g/skQgEewvJ38Esx1IvnJIy7kFMmeA4Z
 rp+dnxDO1CGJM4mwRYjMqmNAxgAQf7g+z6NORK01sEweeSsBHhxqAZia8Ya3OUF0Yh
 RG+ew0GfjqSq0AeIO43vWuZeutzbP1EekMGqEPdc=
Authentication-Results: mail-nwsmtp-smtp-production-main-88;
 dkim=pass header.i=@yandex.ru
Message-ID: <8b699615-eddf-46ad-a234-9f603602f790@yandex.ru>
Date: Thu, 12 Nov 2026 09:54:36 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acl: reject rules with inverted range
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, dmitry.kozliuk@gmail.com, stable@dpdk.org
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
 <20261111073041.38712-1-a.mokrushin@ideco.ru>
 <f350e15d-2040-4a99-b7a0-1c3391cedecc@yandex.ru>
 <20261112062936.16000-1-a.mokrushin@ideco.ru>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261112062936.16000-1-a.mokrushin@ideco.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




> Hi Konstantin,
>
>> Why not check rules range in rte_acl_add_rules()->acl_check_rule()?
> Because at that point we don't know which fields are RANGE ones:
> rte_acl_param carries only rule_size, and field definitions arrive
> with rte_acl_config in rte_acl_build() (ctx->config is filled there).
You are right, I already forgot about that :)
> The same set of rules can also be built with different configs,
> so a field that is RANGE in one build may be MASK/BITMASK in another,
> where value > mask_range is perfectly valid.
>
> That's why v2 validates them in acl_check_bld_param(), once per
> rte_acl_build(), as Dmitry suggested.
>
> If you'd prefer, I can add a sentence about it to the commit message.
Up to you, no strong opinion here.
> Andrey

