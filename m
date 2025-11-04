Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F13CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9DF44066B;
	Tue,  4 Nov 2025 15:52:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B75C40269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762267964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkgSz+/Bl9llR4RFEvJlU8UAX2lCJFvEB41aNv24sZk=;
 b=SVOfTXWHwmt4ihNWbYcwcbeqidYrkSrOxP3SbLCXA+7n+iyq6Nm/TkNfQvou5A4N8mxTUC
 iuTd0ypCs5PDoFCPWWN6Tkw8QJf06eDkcLa0HRNfzlCE+ZwAI7Nq9Z5h+izuIiC7p8VGYk
 nYoDPTu0Q/rdF9nDTaHeqbXYx/KSiZo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-UvdVSOUCOKWiGQvnZ7u6Dw-1; Tue, 04 Nov 2025 09:52:42 -0500
X-MC-Unique: UvdVSOUCOKWiGQvnZ7u6Dw-1
X-Mimecast-MFC-AGG-ID: UvdVSOUCOKWiGQvnZ7u6Dw_1762267961
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-37a35d16347so14616931fa.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 06:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762267961; x=1762872761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EkgSz+/Bl9llR4RFEvJlU8UAX2lCJFvEB41aNv24sZk=;
 b=Pw1d32LpN7me9cdOjcKLsrzFKviI1xjTKgyG3C44vBZQH94Axs2F5DePWFp8pchHBN
 Ld49z/icVDA9v2bNo3rzyI4norOnhLKHdefGt+ROJsBvLCbt/8vMe79cPn0vf0TcohiY
 rLMDd91GaeAS44RJY+yS0J8n1xFxTQIx/cFvbo/odEg8Lfd/G+4INW35aYnG+jNYjKir
 r5FSWIuYC8EXi633mSVVoZTrPo9XP0aNdTyurXQU2I0/liaVWJ/4NCfZx33nJCwiDgq4
 Xx0ygXqO7oXXn0B5vyMbSh1K+WdiAhMPN830CT1eTbUgb+nfuUSlrnjM56WhL9N+yzBA
 f4kA==
X-Gm-Message-State: AOJu0Yx2QJ+THD06n0mg2Dyvou73vkjYPKm+jTo5NXmeZoVqQejbEP1I
 gdEmM0bOUjKpqTq+/tEHuYQRDBd6D6GbF9pAznLxkqq88XcWHj55bXYl4gz7Q7R+eNSu76wK7OB
 7NxmX8enNQ0dTynlyHcHdtpsHz77jEdCTXJPe2hNQd+KL1nxJH5SfLslD1fGTOUepNbmd+hstKJ
 YZlynS/dFPHYrxm6EI1MTrQtr3LSk=
X-Gm-Gg: ASbGncvoVN/MgnYvWVkT91I5GBzqaYrfhF6HPcunZVoNkvSALU50ppxjxMosIbT47cN
 Z/vNqQoA6wapn0cv6aT+1pbJ1qWcCo8CgFzBgmdiwBGdj/o3RIjPcnEBxeXA6mJy7V2r0JjyN9q
 JZzMyQJAg9g8uWeXKAHknY0Mj9LP07GcHL/c+nvHGpUt5ASsgS08XL+xwZGQ==
X-Received: by 2002:a05:651c:221e:b0:37a:3c84:9d44 with SMTP id
 38308e7fff4ca-37a3c84b3bbmr17227591fa.49.1762267960665; 
 Tue, 04 Nov 2025 06:52:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU2e2dndPo72EUJJy0zNg4KJ+eCQH9cqahCC6s8KK2dh93DkUmiHw4eMAHpuWVI06GJxODY59wzzLd8liipes=
X-Received: by 2002:a05:651c:221e:b0:37a:3c84:9d44 with SMTP id
 38308e7fff4ca-37a3c84b3bbmr17227551fa.49.1762267960238; Tue, 04 Nov 2025
 06:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20250904134531.2171206-1-david.marchand@redhat.com>
In-Reply-To: <20250904134531.2171206-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 15:52:27 +0100
X-Gm-Features: AWmQ_blzeTrOANAIfvekTjgHd3L9Fh3TUlPIdQs6EoESrmiqpMIdDFktcIOI4Vk
Message-ID: <CAJFAV8zKMy2N6Qmfcus4vO8P0Gu1H3Q9fSubE0f+M==ziMSkvg@mail.gmail.com>
Subject: Re: [PATCH] ci: switch testing to Fedora 42 in GHA
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qxMvwyKVaz8IBxbFgXBr12_3BcInctpSU0cCm6uj6zE_1762267961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 4 Sept 2025 at 15:46, David Marchand <david.marchand@redhat.com> wrote:
>
> Fedora 39 is EOL for some time.
> Switch to Fedora 42 which will be maintained for a year (until May 2026).
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Fedora 43 is out and will be maintained until December 2026.
Using it will cover testing with clang 21 (that shows new warnings,
fixes are on the ml).

I'll respin this patch.


-- 
David Marchand

