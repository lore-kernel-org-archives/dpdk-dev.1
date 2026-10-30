Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7FE606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Sw1R4rjG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E804025A;
	Fri, 30 Oct 2026 06:01:53 +0100 (CET)
Received: from forward503e.mail.yandex.net (forward503e.mail.yandex.net
 [93.77.172.88]) by mails.dpdk.org (Postfix) with ESMTPS id 1699A40151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:01:52 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-36
 (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:351f:0:640:8d94:0])
 by forward503e.mail.yandex.net (postfix) with ESMTPS id 0CD06C0340;
 Fri, 30 Oct 2026 08:01:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id
 Y1cIr4WdaqM0-xN5oFgXj; Fri, 30 Oct 2026 08:01:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793336507; bh=c7+i8YaQRwFWz+uRmROJFPPMvHRbndJXKbbyREJJQjM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Sw1R4rjGfIO+6oBKge2lTzGfXUCRLeMiL1yVZGCEj5Efz5TqBEIvZgzFyQgwNS/b6
 psaQpEpw1F+CqoVTjr3FLLzR4YQ9igd4/0hcACTNY4aH8nRDo5DUqKoSlZO0g5fFnZ
 Pw21sYnppQ4Tx+Eneas7dHYxi0ypLFMXM+UAiOJU=
Authentication-Results: mail-nwsmtp-smtp-production-main-36;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, aman.deep.singh@intel.com
Subject: Re: [PATCH 0/4] move module EEPROM decoding to a transceiver library
Date: Fri, 30 Oct 2026 07:01:30 +0200
Message-ID: <20261030050130.1788565-1-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029135248.6d813f58@phoenix.local>
References: <20261029181511.1736967-1-roma55592@yandex.ru>
 <20261029135248.6d813f58@phoenix.local>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 13:52:48 -0700, Stephen Hemminger wrote:
> Warning: no release note for the new library. Add a New Features
> entry to the 27.03 release notes

> Warning: rte_eth_module_eeprom_parse() ships in 26.11 and is removed
> here without a release note. Add a Removed Items entry to the 27.03
> release notes

Thanks for the review. I will add both entries in v2,
once the 27.03 release notes exist.

> Info: lib/transceiver/meson.build sources are not in alphabetical
> order

Fixed for v2.

Roman
