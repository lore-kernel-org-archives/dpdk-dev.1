Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7ACD98D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 20:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A89740281;
	Thu, 13 Nov 2025 21:09:31 +0100 (CET)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 73D0840151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 21:09:29 +0100 (CET)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-787c9f90eccso14078367b3.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763064569; x=1763669369; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=YFJmDx7jiiasbIy5RBYaX51U9j4Q7EEukdxNLrbMXwFjkv0UoycTloyYM3jhRyXZK+
 CBg0OVugbYyjnN2AA4wNbAneUwNKPN6JhNktHOBUIPrt+iDxS2uxcOdAvMHDaxWAjNPA
 oO3iddnRzHq/XVuK0P0elvQhWS9jhITekkNDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763064569; x=1763669369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=OdGdd1m9ifdWYTxuwpesmsJcbsr2DfSqMoI0enTRpWZERUN8bT5a497nAK9RhczWc5
 bBJEQqopDJxYmDT34oxEV61EG6N+J5Y4s794V0cnKOFrjtl3a4W5ibQD3ucQua9k4sv0
 Lv73RDajgPP5TxHImM6zsF811Kxlb+PSZoc+nSmHnETtniSY5pITIkis6k5eAjhtE48/
 KteenuO+wkfzBJfRkKRzDMYxmvDe0uUnAiGZl1xmmsroyvusN2WMODOO5ERSnRtYpPAH
 9KzsehNsCqaBWkCXbqJSZo6FGQw5/K2kL1aU0rCYjA4/q0vpa2bCU7zgmCpoZEEvB4++
 3fTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu22jnEA3h62yiLx7IvZ6ytQOL6lkidA/rDFdyEqPqob/n9EdrqiP0/CwF8r+YN6usUYQ=@dpdk.org
X-Gm-Message-State: AOJu0YwZOJKyyXtMArLUAXx1SPImlJUd8LzLNKVsnFG4ZdBEVTlAoHS5
 /QID9+st8xbEE9FdlIiUJSuqKscRx5VZ0oIXZv2uFwBL0EnDFjl+CUhC4UEpAXvMJ2+mJCuo8AI
 jq8pvMvDnUdVfxpJC0ixHzwCTgLHtNBC4HoG77B4tzw==
X-Gm-Gg: ASbGnctNugRly9pbT2iccbo63UoBtCkHajFvs9gi1gVwxcQDmaJfXYPtffQXVi3PIue
 euUyLDPu6+CuZhX/ch9rWRgMbSfr5sNCfE7pCrJQaM01hUq2JlWfufkIAE13yIPp10PU2j5U4FV
 bnBzF8/61gpCaQ9GI06Io+k4jE/t0APJNu7zf20v+pYYYl0FKVa2wlN0LaeqDifL9u/Rel6VNLU
 gCl68Jy5uBdYei5NA/DVPPqXRZ6hGtp5XfZfZE26RAtSamJbdtZVR/xcmkI6pr511cacDT57NSP
 viHvrdbKsZ+UwkmsjwAJ
X-Google-Smtp-Source: AGHT+IH2gRZw0Ws6+yuSYyTPQBHyeJOBJjS+hqQsAwchG5XkcXDKs1G/pStBn1ZzwPTvMfUTuo1ozg+XWnXGJqRdysg=
X-Received: by 2002:a05:690c:6303:b0:786:9774:a3d2 with SMTP id
 00721157ae682-78929f36bf2mr7049767b3.69.1763064568704; Thu, 13 Nov 2025
 12:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251113012732.1059669-1-probb@iol.unh.edu>
 <20251113012732.1059669-4-probb@iol.unh.edu>
In-Reply-To: <20251113012732.1059669-4-probb@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 13 Nov 2025 15:09:17 -0500
X-Gm-Features: AWmQ_bmCyJs9ktj50UKfbSDfop3XU9ygx9zF7TCk6OB8pRCJtHY8sDkt9eimUXk
Message-ID: <CABD7UXNcTa32xRO8R46MCXLts-vDGgxHwaMc8yoNyH87CeNyjw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] dts: add performance test functions and support
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>
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

Tested-by: Dean Marx <dmarx@iol.unh.edu>
