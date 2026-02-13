Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BBEF99CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:33:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384C1402C0;
	Fri, 13 Feb 2026 20:33:08 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id EDC8E402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:33:06 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48374014a77so8884095e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771011186;
 x=1771615986; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIWg2SKgxPvvZ7coMGDbNu6vQm5XE1KrC2YD3bZE6PQ=;
 b=eBF2isyiJ4cYvLTKMylhkPjryKb/WyECziPNkLiVf6WoMYN6j3wopwP0WYxF+T205r
 aH8tfaEYYPyiFlkeYQxqmSB3Fy2md2cN/zTMIY5DpsjenAFaXR9q0+AguOuCR+PO9M5B
 1IYE9uFLL1GCcEqOi+Ta26ee7wolmDMggKrY4iJ+rWoOzqNcWaDlDWrAtVK68bUh7ezZ
 tbv9kfGa5uGN39E3poRF5Lnw6D9VGgOXyYN3if+lCh/dhQJTnZuQ6I+FyzTDwj1mbpEC
 e1/WWsBFgNciLOZODggbysJWHcuXfRmkTpqr3PX0Yq6Cw8xM/iDVRiIBOUOHpLreL1iW
 I8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011186; x=1771615986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WIWg2SKgxPvvZ7coMGDbNu6vQm5XE1KrC2YD3bZE6PQ=;
 b=hWZyOBktzNL/fkMxnVMWxqPp5StESb7e+1ONfCqxgooWkU+el6DStJ07E1XVyH1Tt4
 YoLmotWyMAE3V7SceRHfCCLm7qXDtk7LjU6pcjD2UVceCmDQd/W2PdhYSRtqgsExcA2+
 r1isIkqV+B94lf3qpswEwR0k3+wy2KR9ePE4M7ipLftoHiml1PPi6vw4T0dXmTJFKO16
 rRN/qWU1gBskU4Cv5sZ+00EgBRRrSdZ2+eYHDeuGC94CmXhtg6u88MgVRVZcuwgoTALh
 pXKho23D8dYqgON1N2VMUW9JuPhe+Wo7H4W3l+8tEr98DKHQ0RJy7JCmmE/ebGkSTKe6
 2BzQ==
X-Gm-Message-State: AOJu0YwwGeWxS8tmWuQbNFRE0o83LdoftheOnbG0/2pHB1i78B8amfUj
 Bi+bjnRoqQZVk9A9kqYSStTs5JYii6Cl1p0hEWpmwukpKlXhtv+vA+3dSzFZTTB5LXdHmkSFJKY
 Syc2C
X-Gm-Gg: AZuq6aI+1Ua9jd/A8fHOZp+gPRRW/nMYUPPqczfrQhvSimIHnm6KlwsuKz5suFAu4wX
 lt7zqbyYGYlOYIVA0sE4P4z6Mi4GOtHNlkW0mf+O44Oe57YEDXZJ9LcrZafHWXE9/TN7rIHSLNF
 BuNPnF5V2bfuU6UwrtAW6bfRPco0wVEWs8IOo+yBj6ikAbdAf1quVs5vPpDxM9QcVrwjUfGDSMQ
 n9yAriVWlOWhl0H1D8YGBFYrUDJJxXBcpswLuLgJ3XEFnf47VacGERZL+3+7/ylFKtVe0lbp1Yq
 GhBuULrsRfmxyR7nhZu70oMNX/Ykbx82bnTMDZDLVKdqZY9kseSjZKG3sHsWy77JIgynIgoyOOD
 aCOguSp557/TTIf8yvyL/ZFZHhoDGZBEbmy1xX6xmjZzqU49DwR/BIA1aPPyfHzufjNGU6rlWRx
 6F5oXFRvWOPisfGfCYBS7AFZV4YoXzZMs6VkPr2RVYv5DJ1ORGbIcl688S7+DWu5Hx
X-Received: by 2002:a05:600c:8706:b0:483:6fc6:1e20 with SMTP id
 5b1f17b1804b1-48373a09effmr44113995e9.9.1771011186298; 
 Fri, 13 Feb 2026 11:33:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3ee00sm23949045e9.1.2026.02.13.11.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:33:06 -0800 (PST)
Date: Fri, 13 Feb 2026 11:33:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 2/8] net/nfb: create one ethdev per ethernet port
Message-ID: <20260213113300.55886830@phoenix.local>
In-Reply-To: <20260213185317.1893353-3-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260213185317.1893353-1-spinler@cesnet.cz>
 <20260213185317.1893353-3-spinler@cesnet.cz>
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

On Fri, 13 Feb 2026 19:53:11 +0100
spinler@cesnet.cz wrote:

> +__rte_internal
> +int nfb_eth_common_probe(struct nfb_probe_params *params);
> +__rte_internal
> +int nfb_eth_common_remove(struct rte_device *dev);
> +

Not sure of __rte_internal is needed on driver only functions.
Other drivers don't do it. The purpose of __rte_internal is to guard
against applications randomly picking up functions out of exported
headers. Since this header is not exposed it should not be an issue.
