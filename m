Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE2C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 00:46:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 043144025D;
	Wed, 14 May 2025 02:46:40 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4AF0B40041
 for <dev@dpdk.org>; Wed, 14 May 2025 02:46:39 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c5e2fe5f17so702712285a.3
 for <dev@dpdk.org>; Tue, 13 May 2025 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1747183598; x=1747788398; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1i76OjTOCaPtG153yLB4L6nzkHIWLmdgZg6Jm2HLJmI=;
 b=sTtLwLGntbHAj+oC15tHl9CopvBOTtKacl5oSqiXBIT2lZD37ojT5OPPBK7cD5VEDT
 lkDc77rD+mDgwRgl91JxPrXn7Qn7HDZrYuP5sELQUZfH1ZDZeizfZYHoOTApqqlRsL1M
 m0s6pUAJ4URsAuedC7JrtY7wZWo+K8NKek0vvjdHk9IpkCHMWm5MUshlhcvG3empMLMR
 h+fVNeUXvIPLydTtuWZCf8izpHNMAO25WTOJcFV2Bc+8oufRZR0Pw2RSaElFenbiHzZY
 LBDOXmenMtzx4OMjvx106vk/hsABXE7qNdZsAWgO/xjmP0fno45eCbyfax4Ycu87Qhgu
 98Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747183598; x=1747788398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1i76OjTOCaPtG153yLB4L6nzkHIWLmdgZg6Jm2HLJmI=;
 b=b7clHtW5DF3Ivl/FaD0budinU+QDJFgiTDgjOh3yRGzmBSqo3/DU9CsT9cDl6Lv2uN
 KJ6xDZkUxkpEAxEagzUsX7vhcDkHLgmSkem6JhtMCo/FqvHAvwiwQMvVdyy2B/lc2kiA
 VhyDveEsKm+7mTU+WFDVTJztUI82Z5HxAohA+0gIAQ7HOR8k73TdXdS6Fs7lDTfnansR
 6LZ2xM3n0Rs8mc8H4nXTxH+bmu74JliDGjgeN9fCR7SRw0Pk4fkbkT2mbp5bUIKDuF/l
 mJt46IVgW2G63IYjn7czfmjSAdPKTiCVOq3RbFjZxLaZ46ZTnLC61Qxn8paIfI9wg7I2
 c6fw==
X-Gm-Message-State: AOJu0Yw7EvEUzYVgGrvt0oUaj0P5T0FqJyNVesSxXp25L+d/a0tcy25K
 5n4QTZdzITEsbCDR1Mgi/k2EXWT9COyt5bhpAOB+rccC0Rj9YW8b7PK4NlzH6d9NEtMlPNPebUw
 3Ch7CmCbnod4DRwUQtGSq8qnWF2U1R7vL/8P9
X-Gm-Gg: ASbGncuI8I4nNIMarluiLWSl9qdikkas0IqaFlAEsUnnSE0qJ/aKsH8wUxv9NCoCeJ5
 ROYgdOit/uUoPaqr+rX4RqyAU+HxrWZCnd7MVve0CHSfOmL4M0RIW1Uksy0c+rlqYa5ynDsvXj5
 b0DQSknwXv8RbeLtg8/0P4reZ9W/2tgIWaojBXX4xFx2GREVBYl0B1BmKLk+hHc3k=
X-Google-Smtp-Source: AGHT+IEwxdIlNYCGNR2G5aCCgz7WBMiADIuchxNs8qkfnJBHEYIR+OWp5tbnxGV/WXJAi0d7Bs74xYygsIYU3N/6Ilc=
X-Received: by 2002:a05:620a:2985:b0:7c7:97ff:ca42 with SMTP id
 af79cd13be357-7cd28856392mr248471785a.41.1747183598313; Tue, 13 May 2025
 17:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250513235308.2200865-1-joshwash@google.com>
In-Reply-To: <20250513235308.2200865-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 13 May 2025 17:46:27 -0700
X-Gm-Features: AX0GCFvatDJugn00i5cDVopfHfxSYLQ8jN0k0KE4smyb7KdJ65H7g1kQi6guxZw
Message-ID: <CALuQH+XJqOAetnTO0b_t55Wf1Qn38dQSZvgj1rf=pTKja6ozyw@mail.gmail.com>
Subject: Re: [PATCH] net/gve: remove gve-specific PCI revision ID macros
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
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

Patch doesn't apply to the main branch of dpdk-next-net:
https://mails.dpdk.org/archives/test-report/2025-May/877522.html

It seems like the diffbase patch only exists in the for-main branch.
When is for-main expected to be merged into main, and should we be
building against for-main or main? Similarly, what should this
compilation test build against?

Thanks,
Josh
