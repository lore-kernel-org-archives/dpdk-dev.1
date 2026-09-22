Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7DC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D53402B6;
	Tue, 22 Sep 2026 14:33:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6810A402B0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 14:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790080383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/pSIiavPwC+S6oTvhx4DZyWC1maBBoWq7kLoVEghuo=;
 b=YppCeVVnIh7/oN/IeuV6JqyafmIwMS2LuKDsyJ6Nob3rs+avOwPSGfm0f7dbvNPZv3KI16
 p3/aPIXgXeCGPDWQ9GZXm8rs2xMl1K9n9CJt4Fs82LYGTx70LUYEF2j95xRnMrRLcxNl89
 Nz9MB7OaAVbG9Zk2+zyKCz8+nYv0yzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Ay6SgY8UM4WIHVL9iLVwFg-1; Tue, 22 Sep 2026 08:33:01 -0400
X-MC-Unique: Ay6SgY8UM4WIHVL9iLVwFg-1
X-Mimecast-MFC-AGG-ID: Ay6SgY8UM4WIHVL9iLVwFg_1790080380
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so45802525e9.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080380; x=1790685180;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E/pSIiavPwC+S6oTvhx4DZyWC1maBBoWq7kLoVEghuo=;
 b=MB5xfZkP7jo4HQAF39izKLfNzEdQPuYldnJrM5CTh5zAy5wZOWfGLTvoXTN7lGEnG2
 NWU3dmfFfvbbCfiu3Wi/+964uo0lNQAZ4gX4nqi+9s5h7d0FEShpxDp0DgIk8bGPXahC
 OVVkHZQnI305o4v5boWTTjgEqmMlxQrBb0anCONX1dLQZ4IrCB5DzOxh454EXl82lmeu
 CrTIfgx1/hRu2GMZ7lTu8dq4kKvP2ckgB0E3FryAopXV2rk0r4tYXObiB+APwaHFbat8
 ybOulgOzcRxZUXpp82OZjCfYSjDdQfenD8lTN6vgo6dmkeSTjKm3vXnXNKLk9g23uX+y
 p8oQ==
X-Gm-Message-State: AFuF++kGu7e2JCf6Nw1LumS+d7Y2JoRGyZiTObUzqzQucQtdIgVpkm+A
 vAmlKMVp5aQ1ySPz+31+IEjjrOvbaTozI0sG5x7Ksb4B5mKIjGh/XMm1a/4AL22VSgmlN7lEFr8
 pkdq8j8ami6hffsuFipssOxct/RrteXcX+Vy6ufznGxCSvyGHPQzU9m4b+gXl+tZ0nmfIKksMUK
 a/WxqezGBFXpffJkQ3OmCa5oObH4A=
X-Gm-Gg: AYBFou1fEZ6FCX8TZ4d64TsKQjyWwClNHP1IUmo4gykxc4eYLbJSCs3UXvdOBdJxc1+
 xulHpmsr//xqsJlHMoNIMBQfHHT3xiPRJY28I+iv0g7e5goL2KrKggPNDWBS9ztLUKoQYn4o+SQ
 TXPZscC6dA/xu3A2svpawpZ4COGO+HD8W8/wNiPioZlUHxj/WLDi6j0RvvKc5W6CiFp67XXHWYG
 QLsvvzcyv0divcqQyneN9JXjLMdlXULEM4zi3QmIABSOKRX72KlqcOF7d7/aCQBt1Jm9QdyHH5Z
 dL4pH29OtSg5dNSliHFFtKHeqQRYeIke7j2KiAKxDIJXq4pe5Jut0A+ubS6lh6lQSjxBcYyL0PP
 DTuv1j1zV/LIsBipmcXyuwqxkzkq5
X-Received: by 2002:a05:600c:3f07:b0:49c:ee01:8c53 with SMTP id
 5b1f17b1804b1-49fc56713c5mr217532825e9.2.1790080380582; 
 Tue, 22 Sep 2026 05:33:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3f07:b0:49c:ee01:8c53 with SMTP id
 5b1f17b1804b1-49fc56713c5mr217532255e9.2.1790080379989; 
 Tue, 22 Sep 2026 05:32:59 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862775412sm4934135f8f.10.2026.09.22.05.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:32:59 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 18/18] doc: recommend secure random for unpredictable
 values
In-Reply-To: <20260915192207.3926217-19-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Tue, 15 Sep 2026 12:21:16 -0700")
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20260915192207.3926217-19-stephen@networkplumber.org>
Date: Tue, 22 Sep 2026 08:32:57 -0400
Message-ID: <f7t1palcvpi.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pOibbJRn39KJixPV8LgUbG0oRToL805r9o3HyJLufyI_1790080380
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> The AI review checks say not to generate keys, IVs and nonces with
> rte_rand(), but do not say what to use instead. Name
> rte_random_bytes() as the replacement, and extend the rule to the
> other values which must not be predictable.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

LGTM,

Acked-by: Aaron Conole <aconole@redhat.com>

