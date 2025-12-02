Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9436D116F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 13:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C456040268;
	Tue,  2 Dec 2025 14:18:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DC3B6400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 14:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764681509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EIoDpWe6CUqS7uG1Qq+uDa3dEPOLrnfYJ0B8lfQ6bDA=;
 b=U0Nyp3tN/5vMOCgGEF/NgZQ++0fsUyZ4tmNlqjZTMu6JqT2uf7xm/43qII9xN+bx2d3Oj8
 +Pyk6rTZl5V96lN3+uWdq2FQfXUnbLuYOp4yVRK8F8SW7jG26M7HJHe/MqHdSNrVSdfwIC
 Yq58MBOEKYWNL4oiil2+7IPKldTxVWQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-EVhwpAojMsS57Vo9ydrhtQ-1; Tue,
 02 Dec 2025 08:18:26 -0500
X-MC-Unique: EVhwpAojMsS57Vo9ydrhtQ-1
X-Mimecast-MFC-AGG-ID: EVhwpAojMsS57Vo9ydrhtQ_1764681505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 090D01956095; Tue,  2 Dec 2025 13:18:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.134])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B35E41955F24; Tue,  2 Dec 2025 13:18:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net
Subject: Re: [PATCH] version: 26.03-rc0
In-Reply-To: <20251202130819.3805720-1-david.marchand@redhat.com> (David
 Marchand's message of "Tue, 2 Dec 2025 14:08:18 +0100")
References: <20251202130819.3805720-1-david.marchand@redhat.com>
Date: Tue, 02 Dec 2025 08:18:21 -0500
Message-ID: <f7tqztddntu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QoFOXOMmcnIiPJ0EbxIR23L4TGzsPJNv17huVSGglG8_1764681505
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

> Start a new release cycle with empty release notes.
> Bump version and ABI minor.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

