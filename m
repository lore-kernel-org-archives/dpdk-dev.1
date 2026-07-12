Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ADC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 16:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CCE402A7;
	Sun, 12 Jul 2026 18:18:48 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id BFB984013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 18:18:47 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2E44AEC0141;
 Sun, 12 Jul 2026 12:18:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 12:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783873127;
 x=1783959527; bh=k7gP9i5p41rQRUiiBUxA7Bh64Jx6zI/L0E9fhy5dOd8=; b=
 drPagwtnEO7TVMom/sPodEz50SI0dcDvjcNv0PzPXgDiD1HSF+tEr6wgH4GKplYM
 V1Q1vkMPCaGmKBC9B4CzuSEH9Y4526jpjzaXb7bpP0MdNHFSd4rIrYH2ODgDtJ/v
 affLHbiHYa+9A98LT1xFZbghdT5GCxk6R2+G+uOJpctJI/01abOP98XggEEsDZtF
 hUd96PU3v8cjJZm0wm8Ut8qu/28SpKxW/yx46YF2Q+ISAy5k+flbXmHkQJ9/dmx2
 l2s+oVs5HniNlLXquXYlsoibRwSlHcqy+mMCYwo9nuxOYj860pLqi2AZRCAefcfm
 Y6ohF3E2UgqiIB+u1D+Csw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783873127; x=
 1783959527; bh=k7gP9i5p41rQRUiiBUxA7Bh64Jx6zI/L0E9fhy5dOd8=; b=n
 9OmnS3ggzqnMqa1Hq8NB35vri2oU/OKXHSQ20wLAKVIUQSUQKtRuplTuuyAAXkjR
 5pmzonvgpRkbjWZiewpT/PwH+BJX5zvgOXUzn8Yp4Knr+E+fvHJ3fZELYrTwvtJs
 uY5kpcPFYBqh9xd2SkLcEm948+Sju0W22QLQmmPt7MV/u8gTjJb2bRMY7k/iIgEw
 V1Oajx0UeM/kvfYtfQejTJpl1jRBqHp8dbnFDpvY9EiNC3/nie426Eou4AQG8P8r
 EdMvu5/CXF3jKcstOr7rDpwWkeGhXvvq9k9+zqbFN4Ojz2YxtIjfjLZTgR4Y6f0O
 mvhHcW1yahJfpk/yrvU6g==
X-ME-Sender: <xms:Zr5TaqrEo5OvPmMvheCTOQ9aOMGPfNeZ9M2lZl0WK9_ARYcNIgX2ew>
 <xme:Zr5Taoz5tMI391-0QoXLeyUsQU_n1l1PFkNgkLAP3lQCojrOAVl_fU-JaC1oYhK-B
 CKtKOLZiWBlX2gbxGiv_PeH9CXlmNvz-Tfnoa3wb_YMwfqlOXkIVMk>
X-ME-Received: <xmr:Zr5TanISJWJJKuXb3ihODHJhcY0OvdPE38W6ZXclk6bGQq294QL-cckIOAwgpqnJWeoAjZZTaxhhLucwD6vRS7U>
X-ME-Proxy-Cause: dmFkZTEowzk8ug8efH91GBeZN7c0jb1SDVQjwSkuweASBNz6XXFaXpYLCD40USQRONPqqR
 /TAPaMBvcsEl+aswd0V/Om4t0E39ocasEBSkdhAMwATiyfHJMr1GUyDjVHqKK1IlwnCu4G
 RuVhFiihx1Nu8jiCaUmRrjB7KstIHqbE8mjX2WlHOWiXwoh2BjTNzL1emtz/1BCm5ZrbOF
 7U74dj2FZ0ORnRM03j2e5+mpVgxAJ9Dbwh7Fsr4o89Y0MCgxwUai/DSTQuN+A4RIlXUOXp
 KeohcgCTB8dfVE+Jb7e103vrhW0shfmkY1HrmAQYbt4YKIimCIIJOmzqBO6DDebfccVbW7
 lbb0ZvG8Agbox6DzTgiKMEoeW6IR7f+e6tRQOwjF/wtC4iUCyWi75C9bLcMrsJBx+AC5Ze
 vmxL7oNgZV9vDE2s030R3sl8ACQTITAo0Kxh+8UW8T1rca4FB5rJ82AohmOaZh3kwTyf1a
 LvdrFIKI5t/7qARcDK+mPqG/dILCP7xdDc00gtadSHQqzUU0C2gvV0Fq6wKdXClChefX4r
 ezRJoUoMew9QjgXYMMPUFJMgChU+/5Dz9pbdnitrgmTc8mFHp8BYWnuh9appoiNrdGASpS
 zwFCQYbdx9vJoNUUPgSzHNITFgVZuhhobUbFEAE2v8jhs8dD130XwARSfPjQ
X-ME-Proxy: <xmx:Zr5TaiIHolhwKGif5aEvNRYlUMFi45SOMjo2RJF5nOnqDsBgl9HV4w>
 <xmx:Zr5Takujp8xAEKvID3NYVp05hEgp_ei-0gM8JqxU_BDOUhjWtlzW_g>
 <xmx:Zr5TavT2WSzlqTW5jsDAh9z8dqalRkqcgm6CPqjEeF5ghIMyWwhAKg>
 <xmx:Zr5TaqOTXqTJGsjgsJ7cZSh-ZvRZsF49deMEViLisj-q9p-iyHAs2A>
 <xmx:Z75TanCaz7OQyzjXsk81t6-c0DKJYGaw1Sy1HR2bFpaB1-uYtvDVOqtn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 12:18:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v3] devtools: add Vertex AI to review scripts
Date: Sun, 12 Jul 2026 18:18:42 +0200
Message-ID: <8yANTemdRNK0q0uGAXaeUg@monjalon.net>
In-Reply-To: <20260625123237.832480-1-david.marchand@redhat.com>
References: <20260601132402.1125588-1-david.marchand@redhat.com>
 <20260625123237.832480-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

25/06/2026 14:32, David Marchand:
> Add support for Google Vertex AI authentication as an alternative to
> direct API key authentication. All four providers (Anthropic, Google,
> OpenAI, xAI) can now use Vertex AI with Application Default Credentials.
> 
> This requires a python dependency google-auth but it is left as
> optional.
> 
> Key features:
> - Auto-detection of authentication method based on environment
> - Manual override via --auth flag (auto, direct, vertex)
> - Automatic model name translation for Vertex format
> - Support for both global and regional Vertex endpoints
> - Proper error handling for Vertex API responses
> 
> Provider-specific implementations:
> - Anthropic: Uses /publishers/anthropic/models/{model}:rawPredict
>   with model name format claude-sonnet-4-5@20250929
> - Google: Uses /publishers/google/models/{model}:generateContent
> - OpenAI/xAI: Use /endpoints/openapi/chat/completions
>   with publisher prefix (e.g., openai/gpt-oss-120b-maas)
> 
> Authentication detection logic:
> - Vertex: Requires google-auth library and ADC configured
> - Direct: Falls back to API key from environment variables
> 
> Available models on Vertex AI:
> - Anthropic: All Claude models
> - Google: All Gemini models
> - OpenAI: gpt-oss-120b-maas, gpt-oss-20b-maas (open-weight only)
> - xAI: grok-4.20-*, grok-4.1-fast-* variants
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



