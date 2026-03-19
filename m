Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC9108E1F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:45:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E13444025D;
	Thu, 19 Mar 2026 12:45:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BEDF44013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 12:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773920730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUCueZuOlEgHc2zcUseTNa0djn3KKNz9tEtkZQqv+Zg=;
 b=In0fIX9e7mqGxwGyxjkPmRwVuR2x4hCLD3f/RY9HoSHMbCReOOQl1NqLNZeT5LupQJLTnm
 t7SpRtVP8hQGxkZHaX7mATQSqOQJ8s8l+fpIALOGKNZ95/hgfV+8zJbuDEhTn9DJYiLs3y
 SGk7zRA+n/7Zp9OKvRx6Gn6HFlbqhv4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-hpF2HFj1MDu66VNIJwd-Sg-1; Thu,
 19 Mar 2026 07:45:28 -0400
X-MC-Unique: hpF2HFj1MDu66VNIJwd-Sg-1
X-Mimecast-MFC-AGG-ID: hpF2HFj1MDu66VNIJwd-Sg_1773920728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17A231944F01
 for <dev@dpdk.org>; Thu, 19 Mar 2026 11:45:28 +0000 (UTC)
Received: from fedora-linux-42 (unknown [10.44.32.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53D4A1800576; Thu, 19 Mar 2026 11:45:27 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>
Subject: [PATCH v2 0/2] bpf/arm64: support packet data load instructions
Date: Thu, 19 Mar 2026 12:44:07 +0100
Message-ID: <20260319114500.9757-1-cfontain@redhat.com>
In-Reply-To: <20260310122045.4057836-1-cfontain@redhat.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gU68bSiJ0nCrc27w7A0gY4DBLxOajGOQrV4pR4f-FHk_1773920728
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

v2:
- use emit_return_zero_if_src_zero instead of manual call
- add fast path (direct read from mbuf->buf_addr) if the
  requested data is present in the first mbuf and fallback to
  'slow path' (call to __rte_pktmbuf_read) otherwise.
- add tests for BPF_LD ABS/IND amd slow path.

Christophe Fontaine (2):
  bpf/arm64: fix offset type to allow a negative jump
  bpf/arm64: support packet data load instructions

 app/test/test_bpf.c     | 121 ++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c |  88 ++++++++++++++++++++++++++++-
 2 files changed, 208 insertions(+), 1 deletion(-)

-- 
2.53.0

