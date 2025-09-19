Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC13CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:55:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8F4402C1;
	Fri, 19 Sep 2025 10:55:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 753ED402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tOhNTAJ1isQtaRdyZrgg4mNuBb/37BKG1k2/fa2bquM=;
 b=dqG4z3JrOFZP/EBYmg9uKKxXzvxKbLAb0fQoxWgfeCZLFRKwYnGwpTxxpG9N1BsU96usGn
 waT4PQYY2qIlrsksl/oB0HBwRzIVUtz9etbnc9/LLxj3AvT4Zl/ZX77x2gPIBQBOvHhf0Q
 9ZYEckCZumfaFGE3zmVkZMV/n5LFFfo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-TVF5KwQANte2sCr1wY8r5A-1; Fri, 19 Sep 2025 04:55:40 -0400
X-MC-Unique: TVF5KwQANte2sCr1wY8r5A-1
X-Mimecast-MFC-AGG-ID: TVF5KwQANte2sCr1wY8r5A_1758272139
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f70a5c9e3so1222381e87.1
 for <dev@dpdk.org>; Fri, 19 Sep 2025 01:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758272138; x=1758876938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOhNTAJ1isQtaRdyZrgg4mNuBb/37BKG1k2/fa2bquM=;
 b=ASY7VJGJhe/c2ktITPasv+Kle5OHiRBjCwNJVZuCzLYjPYfY8jdilSLU8bA7OFguYf
 5OgjxJCPELmnPtLBNYhk2aPYSj6sJvA7/kCkszs0lteOp8SzpS9LTXTpHfQbx69ZL2ct
 Z9hPTOuxYrW/kHUuDj1Vpsb0wPBWV6hW8H8pM3O37fDf9aJ6v5PKKfrBAiuSeNnsPqBS
 zmbY1qBQFzU+GLkZoFT4ytMr1OtO/bCE7sbNBgqcLIezD9piVfoa71CV5DuMgAnz0O9Z
 vcrgQdj2bFe+ErM5GpxbtwDeUTTbHqKIt5FN8Z9G2Y4m0ubYvlD1pR9rHU65vyeBEats
 6T7Q==
X-Gm-Message-State: AOJu0Ywg5HA9xbMgKfg6TB0KwNOcfjWNpoKme2y8nVb8/JTHNhUsGl8U
 QuKHX0JCZNtoS6yGqA1ModiaLcniKybgcXfkpdwOUNE1ntjm+ZNEr9tNSFP80mjGz4J8FmqyZU3
 +D6z00UALmwz9QLkR1zRHb/BaB6Wwn8rr4exq7H3Bk49wTpdOkJ5ckBewD2s9zYR1Xl25luVB8i
 ZUFGrRvy4ukgnguKd0iZE=
X-Gm-Gg: ASbGncvUv5NA6WIpH+fUp1CWTqR5z5cY7gvAhw9h0Gvn6BE1DnVu0AkB5iqsTVfVKSL
 Uk0lgLUge7Ty3Vpr6W58zH4ILssSQW+dzuJnMnFmbFPyEeJr1HAli8elYgL03WASd1akE+cxK3a
 mmO1nolGTzW8yYz+Vyo0IC6Z8=
X-Received: by 2002:a05:6512:6713:b0:571:6a2d:1fb3 with SMTP id
 2adb3069b0e04-579e3191299mr621897e87.53.1758272138526; 
 Fri, 19 Sep 2025 01:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK2z/CFM0FbfNQLmGFUMqZsUUNG476XQkIYi5ZucIztALqz2BPtWYfPexaRLalVri9bkE2Vfu+QWYW7CeLbAg=
X-Received: by 2002:a05:6512:6713:b0:571:6a2d:1fb3 with SMTP id
 2adb3069b0e04-579e3191299mr621890e87.53.1758272138098; Fri, 19 Sep 2025
 01:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250919084404.247299-1-bruce.richardson@intel.com>
In-Reply-To: <20250919084404.247299-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 19 Sep 2025 10:55:26 +0200
X-Gm-Features: AS18NWDSdesBQ61DFLQ5Dp8TSOZx1EbGCalZts5zXrF3NNblUXCQanjGbrn5ias
Message-ID: <CAJFAV8xiUHcpVWVNDv-qaEkRPytxorfAzgHgCdQ+5nFDBTVLSg@mail.gmail.com>
Subject: Re: [PATCH v2] build: remove deprecated kmods option
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S8dOqOajfi9O6omDtixdeG1SmHwXciGPEd7EOdt6vzA_1758272139
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

On Fri, 19 Sept 2025 at 10:45, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "enable_kmods" meson option was deprecated back in 2023[1], so can
> now be removed from DPDK.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

We are missing a release note entry, but otherwise lgtm.
You can add:
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

