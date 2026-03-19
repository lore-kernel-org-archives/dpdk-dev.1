Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A77E108E1F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:45:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAC5402E7;
	Thu, 19 Mar 2026 12:45:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 315DB4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 12:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773920735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04CPhvAyZMOJhQXQzPSw4TinnbJutASTBBiJjgB+JF8=;
 b=EcMPA/NyUHVPQwrAeWmQ22AGUASC7wh9jGirb3MTPL8GPW1xPQCco9+vgG6DFDhbCBcMBM
 EDsQaZjsDKpu1R23Dn0UO11Pm0HuzQB7Gmz3AyoFAanMXAPx/dV/atf7SIx6tue7k+7gAc
 T+ogQ8M1mda2/0DtzNNHK8A7JlqkAgI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-siQBgDyOOMypurKfPwN1CQ-1; Thu,
 19 Mar 2026 07:45:34 -0400
X-MC-Unique: siQBgDyOOMypurKfPwN1CQ-1
X-Mimecast-MFC-AGG-ID: siQBgDyOOMypurKfPwN1CQ_1773920733
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 339351800561; Thu, 19 Mar 2026 11:45:33 +0000 (UTC)
Received: from fedora-linux-42 (unknown [10.44.32.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34C471800576; Thu, 19 Mar 2026 11:45:30 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 1/2] bpf/arm64: fix offset type to allow a negative jump
Date: Thu, 19 Mar 2026 12:44:08 +0100
Message-ID: <20260319114500.9757-2-cfontain@redhat.com>
In-Reply-To: <20260319114500.9757-1-cfontain@redhat.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d7aQYyc0Q946hNqkSpSek5BaVK2U_D-xs-9AOmisE2g_1773920733
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

The epilogue code can be before the call to
'emit_return_zero_if_src_zero', but the code only supported a
jump forward.

Fix the type of jump_to_epilogue from unsigned to signed,
to be able to jump backward.

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
---
 lib/bpf/bpf_jit_arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index a04ef33a9c..099822e9f1 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -957,7 +957,7 @@ static void
 emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 {
 	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
-	uint16_t jump_to_epilogue;
+	int32_t jump_to_epilogue;
 
 	emit_cbnz(ctx, is64, src, 3);
 	emit_mov_imm(ctx, is64, r0, 0);
-- 
2.53.0

