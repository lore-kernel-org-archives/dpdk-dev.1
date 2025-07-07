Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA96C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 13:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80F3A40287;
	Mon,  7 Jul 2025 15:41:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA35F4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 15:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751895682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sjdwt6qvawJ6YqaQJuxj5P9AsylXklqlbAFqN6LGFrU=;
 b=TTTRoCWfTJ8Cy+poGl3Igv1IZTVOXW5XWnxiell6CK0lp7rrPHuQbFxrXzq51AkWjkcVZv
 rB2nEq4pkURs0GjxNnGg6lvrgZWl3EtyS5YmYaeh5GGo4G5+H+m4cU3oRhPa5PwIxoofjs
 wIb9HUd36qMlf+Q9HjZbVyOEKiFa6qQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-ROIX5fQAPRa4Om2TJWpcvg-1; Mon,
 07 Jul 2025 09:41:20 -0400
X-MC-Unique: ROIX5fQAPRa4Om2TJWpcvg-1
X-Mimecast-MFC-AGG-ID: ROIX5fQAPRa4Om2TJWpcvg_1751895679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFCAB1801310; Mon,  7 Jul 2025 13:41:14 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21B6130002C0; Mon,  7 Jul 2025 13:41:12 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  bruce.richardson@intel.com,  Michael Santana
 <maicolgabriel@hotmail.com>, Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH v2] ci: check C++ headers with clang
In-Reply-To: <20250703082010.2002295-1-david.marchand@redhat.com> (David
 Marchand's message of "Thu, 3 Jul 2025 10:20:10 +0200")
References: <20250701113146.1268492-1-david.marchand@redhat.com>
 <20250703082010.2002295-1-david.marchand@redhat.com>
Date: Mon, 07 Jul 2025 09:41:11 -0400
Message-ID: <f7tplecqft4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CM7xPddZ0b68EaSgcrQu2CSzQ66WvOi-Sy7KqUx3gqo_1751895679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

David Marchand <david.marchand@redhat.com> writes:

> If not passing an explicit compiler for C++, meson uses c++ which
> defaults to /usr/bin/g++ on a Ubuntu system.
> Explicitly choose which compiler to use for C++.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - rebased,
> - moved CXX tweaking in the branch enabling headers check,
>

Not sure why we got a segfault with this in IOL:

 36/120 DPDK:fast-tests / eal_flags_misc_autotest        FAIL             3.78s   killed by signal 11 SIGSEGV

I don't think it is related.

Acked-by: Aaron Conole <aconole@redhat.com>

