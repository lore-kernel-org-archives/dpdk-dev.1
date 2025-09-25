Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB053CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 19:38:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F224640696;
	Thu, 25 Sep 2025 21:38:06 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id C5BE640663
 for <dev@dpdk.org>; Thu, 25 Sep 2025 21:38:05 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-851e732d70fso149159785a.0
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758829085;
 x=1759433885; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOIjwqSEOBIHmd8aL9WSU/Oo0fNTDRyP42apXRhk0CU=;
 b=SreSIvoyV9HPjEpJ5PflZCWmezxmhNSZwKt3frEPbuR/zaqf0mc92wlnw45ip3wOLW
 nBMNndSjX04KlHSDJGl/4g9AuzOLj96LBlRvFzEfSa1Q4nPQOzS7ZLmKWICzmMyffD0w
 z0KtKZntwuk3zh92vfeAOo6ZIImJ4VHMopKWI8alE9BSxBgjThl32CQimGLmfcGsS+qE
 HhpmZlcO78paNgMYy5H96YsSC3LfoA+KZMIsDd/nTcRsSmw9F4Z9AWBzOWYvNKYi7Pv5
 SdviwngEGLMWT9VZ9BEqgO6eN/zfrFUTNOelTvLx01Y/gd/91nbWglZeRFbdXnj6bq34
 YQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829085; x=1759433885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOIjwqSEOBIHmd8aL9WSU/Oo0fNTDRyP42apXRhk0CU=;
 b=gUaMlJN+TqoelRRlJoIxUV/+31PRc41A7SDZwMeeBcyhAcXjIqEr8Wi7T2Wa+xxDGN
 CTQyGm4+YLP1u2DxUSfNpJGa3UqWtKAhbcOl0c8qYfylw7aZed4/EkeZXA7o1cIUW4Jk
 swjZ8+ghu7Dnff8gd13xmmmBE54yk23kpoXfmUlzS/0ditEjiWu5fRdUydOIcBnrjzoB
 ELqaQLNhh96Ecw7MtMHSVbnN+a0AhgTchlSjbK9dhquQRU7W6lCy+GcZJs+tnIGVYrbn
 BlwrnfbxIIrSvzwc907qDHqXaxe99Sfdx5+EfGUKrPopqnCDfWt5HmDiO+SGs5InVJpL
 Besg==
X-Gm-Message-State: AOJu0YxyPC6vyffS8palwvlwuUXXS5xMT+LNneN8cTFrdvxMAKi+lmzN
 XED1zutST4U2df1OFAM4hgSnhxmpUzxanQJIKX2EJvoUd/Bsbgf1ui3Wb/E0OGbkfN0=
X-Gm-Gg: ASbGncst3X7Aev4mVjPrSqYv0nkfX09gUNYB5gdmM7/edE5FCiy24/NhQmeaW4ylDjr
 c0mAOLkvjVGlhU6NK+Mx2NRcuonrPGwXOd1FfKlMU+AkruGsM8zDVveiW8jyoizozF2et98x0DR
 C5Ll3S55arH0MxgxDIK58V6exCAOm3cpzumG7f8Y+mIbuhbNWsAurjqYYzc28koXPCeZGY+uNUR
 dh2Ac5gDO+djHA9Yfbb1By9gLqMgBNbcDEMs+DLaF7ZGanxqaoZYaN3eTF3gqOe7hhAfRF7cL7T
 Tw0YHVCJB/b/piNppl1lZIT860NO9cItnaBw9bqGlqlDuHPUnkB1wr6xqJ2ZdH4mLw84FsScYTZ
 UzMpJbvbREu54DjpbDLVL9d1YH7KDX8lmCEYw0sHs/BcJY4aAN2BrwH4VS08W3c7+iGO39ztKb8
 8=
X-Google-Smtp-Source: AGHT+IFrbh2rBEsv68Tt6eIMV/LMGJa++mcnjIavYmG3xL9dh4sNkY16qzU7k/exOFmsghGgg8eqDA==
X-Received: by 2002:a05:620a:2686:b0:82a:9b78:3db1 with SMTP id
 af79cd13be357-85ae97a802dmr587158985a.69.1758829084912; 
 Thu, 25 Sep 2025 12:38:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85e95e91765sm89951685a.46.2025.09.25.12.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 12:38:04 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:37:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Kozyrev <akozyrev@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, <rasland@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>
Subject: Re: [PATCH] app/testpmd: use table ID for jump to matcher action
Message-ID: <20250925123759.5ac936d9@hermes.local>
In-Reply-To: <20250819144508.722653-1-akozyrev@nvidia.com>
References: <20250819144508.722653-1-akozyrev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 19 Aug 2025 17:45:05 +0300
Alexander Kozyrev <akozyrev@nvidia.com> wrote:

> Current implementation requires specifying the pointer to the table
> you want to jump to in the jump to matcher action. It is inconvenient
> since there is no table pointer shown anywhere in the table management.
> Table creation/destruction uses the standard table ID for that purpose.
> Use the table ID in the jump to matcher action as well.
> 
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>

The cmdline code doesn't guarantee that the space in the
context will be aligned. Therefore using memcpy like this
(untested) would be safer. Please review this as possiblity
and resubmit if needed.

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 5d9c8f04f2..04d3dbbdca 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -11221,7 +11221,7 @@ parse_jump_table_id(struct context *ctx, const struct token *token,
                return len;
        /* Get the parsed table ID from where parse_int stored it */
        entry_ptr = (uint8_t *)ctx->object + arg->offset;
-       table_id = *(uint32_t *)entry_ptr;
+       memcpy(&table_id, entry_ptr, sizeof(uint32_t));
        /* Look up the table using table ID */
        port = &ports[ctx->port];
        for (pt = port->table_list; pt != NULL; pt = pt->next) {
@@ -11233,7 +11233,7 @@ parse_jump_table_id(struct context *ctx, const struct token *token,
                return -1;
        }
        /* Replace the table ID with the table pointer */
-       *(struct rte_flow_template_table **)entry_ptr = pt->table;
+       memcpy(entry_ptr, &pt->table, sizeof(struct rte_flow_template_table *));
        return len;
 }
 
