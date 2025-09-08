Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E584CAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 15:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785544060C;
	Mon,  8 Sep 2025 17:02:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5CBD3402EB
 for <dev@dpdk.org>; Mon,  8 Sep 2025 17:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757343751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ih4k6HzYVLHOM/IrrNTOKFIBH8oUYXHH8UlIx8GiFiU=;
 b=WzTmr0Cdf2LguidOMegYWPRtiPke2ggPErj59AF4mHGPxzWs4JJ6ImDyBI4GE67Yjik2gC
 +mnb0OC7+O1y6alYGsACSkQoPcF0rzFbNkYetCI2Xe3kWmHOJ39LVkDTWDu/FQi5KlG6LX
 AHrEdZiAlqqnCAVHRRxvVS14AcvqZ44=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-6BGvKG5BNfmZFtRvicEf8w-1; Mon,
 08 Sep 2025 11:02:25 -0400
X-MC-Unique: 6BGvKG5BNfmZFtRvicEf8w-1
X-Mimecast-MFC-AGG-ID: 6BGvKG5BNfmZFtRvicEf8w_1757343743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 603BF1956046; Mon,  8 Sep 2025 15:02:23 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DA09300018D; Mon,  8 Sep 2025 15:02:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: switch testing to Fedora 42 in GHA
In-Reply-To: <20250904134531.2171206-1-david.marchand@redhat.com> (David
 Marchand's message of "Thu, 4 Sep 2025 15:45:31 +0200")
References: <20250904134531.2171206-1-david.marchand@redhat.com>
Date: Mon, 08 Sep 2025 11:02:19 -0400
Message-ID: <f7ta535hts4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LiF-45f6UEflBfX0SazYwXdY5SZpu5z1RFSY7XTvCpQ_1757343743
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

> Fedora 39 is EOL for some time.
> Switch to Fedora 42 which will be maintained for a year (until May 2026).
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

