Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AE9C369A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 18:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 873BB402D2;
	Mon, 14 Apr 2025 20:32:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 14CCA402CC
 for <dev@dpdk.org>; Mon, 14 Apr 2025 20:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744655545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pU2DKIVPzAOpvc/fzXnHPmZPf6eIETyNKZcvPXqMEzM=;
 b=g2LY/h+PoyRyyYiA2FarDinH6LbzuO3XoeyhNm6GXQQx020Exz2/uDnlGqLOx3Vq8Ym6Q2
 ZZibmdoBqlwMXEEciGF0IiMeA0dbNhdZMlxOWxcdpo6IU1iZZQ9d31RSjKjD0IoJrCaDxM
 rSxDwudurwOOQNrrPTpdmqrI9wjaGS8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-ZALiw-QyPtStFroJnRmRMw-1; Mon,
 14 Apr 2025 14:32:23 -0400
X-MC-Unique: ZALiw-QyPtStFroJnRmRMw-1
X-Mimecast-MFC-AGG-ID: ZALiw-QyPtStFroJnRmRMw_1744655543
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D722180AB19; Mon, 14 Apr 2025 18:32:22 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.251])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9874E18009BC; Mon, 14 Apr 2025 18:32:20 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net,  stephen@networkplumber.org,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: check licenses
In-Reply-To: <20250411071857.3355590-1-david.marchand@redhat.com> (David
 Marchand's message of "Fri, 11 Apr 2025 09:18:57 +0200")
References: <20250411071857.3355590-1-david.marchand@redhat.com>
Date: Mon, 14 Apr 2025 14:32:18 -0400
Message-ID: <f7to6wyfvbh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bRuRaZno2eqXvJOqEIKlsyP1X3KXEKm4BkfMVfqAzdQ_1744655543
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

> Call check-spdx.tag.sh so that all committed files are checked.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

