Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABCC982E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA9942E80;
	Fri, 16 Jan 2026 18:36:42 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id BFFDF42E7F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:36:40 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so14361795e9.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768585000;
 x=1769189800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC66NbFOC7vq3W0ENWm8fpFynoat/Ug+/VKxdSjXljQ=;
 b=PO+hathtySLnAX6MXvNS/G5C0zKz5XGbN/D2SJNZUL319aVC3vf0gBIdssy6twwqkv
 1u+YtoOXNDWYH5tyqELIMEZDa8yP7R6rj5d4Khm0FwdlKuc+3/x8e04BSq6+YnNx4E9M
 FV7OQEGz6a98xbrGI3vMqvvFmxmLhpHbIhnwObZjSe6JFP6JMpgpdMT6Dzkj95ndYjhq
 xU16hiVv8Tz5n8MW6ljvjmMV8wtN/09FMi6oHqcRNErw/oGjNeMo/QfLynPA4iIzqdEV
 mfNpEy5WQld74uMUmCMgtLfzsTKmpTdTn1xHshzCf8cNhqFkCxBRPN3vlj61KO54Yfch
 HYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768585000; x=1769189800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BC66NbFOC7vq3W0ENWm8fpFynoat/Ug+/VKxdSjXljQ=;
 b=mj6OwhSxj70Rsy9Ee22M3inVgiXvxbxz8/Yz+8iSPpTFqghMRPaX+//F8Z4MD1kcb4
 W450pCgyuMqYzkJuEL9suQGa3byecafmTejZHm6L3IlqdW5S5qwN2jkrQP1cTbUB3xvc
 gnuawOc9oOiZVWADi13cPx1kVwQs1iGynoNYCTiLHYQ1n9vWBo6hW0OokYDZtdn9EfdA
 C3NYuPrfz20U6CyRo3rBUk3kPj2CW3Z1O2rGr40j4nVBkTJ7o77Syv2fI9RBsOjXWkhh
 xt/8IAZAri0TJpPyuzLdG6oXUsvX4cFjL6Ju1VXmvZj++GgP+eZyTSeSVrmctnRdFpaU
 iwnA==
X-Gm-Message-State: AOJu0YxeAp54IB4SL0mzzScsbHdVWg+bE9jxxuPtWvXiaY2yScmfqERa
 zbcnsrNoBQOwchpgPz945GxUsEM1r6LeApCjbY/2HNFv5PWeSNPZUxIxNOQjiwiOC8o=
X-Gm-Gg: AY/fxX4FnajVmTWi4wjO4IBIf2FpgxdszKF0/tgiJxnkwfwEzNwrqabn8VHZrfJoBWm
 nQeqIhKEJ+CN0JWmT96MFraHvuOXGgFM79CYViT8hqj52vgx4+b5pqaXhhSUG1hhQzUMkOnF2rf
 vpOx6i8KIax4bCZ3aCR8BAayyv7trmBgG4ajhnvc0EAOn6HtST6zDAqE92M9sSgiTjszuYSiezC
 4aG1v/xuQj+L7M08XvZmsSUWjwCY9Orsz+P1oaGjOIbAZB8ODGnRr5pwe8sJHgFjtqTMq50yqni
 4gY9ZscK88cIIPRnwyxqDNE1C42Pt1nQ7y7oA4XxZEcb1oQHYdIBASaKMOEFURqFucAMBgl0pcH
 KSPSsrjsjOqbg1hr7Dmy1gVmF2sSqYp6Ca5/LSYHPxNdw981BeCq9FIZR0SU/OeQf31PEwwOR+w
 TVkhdnWqfx4OJ3zeoFkTIdq2YtTC1o5dzy76sz+RsgMvq7x5nc/Jb2D9bSmx9/pMs=
X-Received: by 2002:a05:600c:4ed3:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4801e33c0d4mr45822365e9.22.1768585000346; 
 Fri, 16 Jan 2026 09:36:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f429071besm107553655e9.10.2026.01.16.09.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:36:40 -0800 (PST)
Date: Fri, 16 Jan 2026 09:36:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 4/8] net/nfb: add device argument "port" to limit used
 ports
Message-ID: <20260116093635.5cbd01cc@phoenix.local>
In-Reply-To: <20260115151656.393106-5-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-5-spinler@cesnet.cz>
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

On Thu, 15 Jan 2026 16:16:52 +0100
spinler@cesnet.cz wrote:

> +		if ((port_mask & (1ull << i)) == 0)
> +			continue;
> +

Use RTE_BIT32() maybe?
