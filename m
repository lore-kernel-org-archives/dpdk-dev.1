Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB431067058
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B439C40613;
	Thu, 12 Mar 2026 17:01:27 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id 0BA0E402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:01:25 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso825742a34.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773331285;
 x=1773936085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJxsBIHex8kkMZ9dPlivoJgrHpKPpVcW4rflydP2WQ4=;
 b=YOdqg0oNi59/Q9xkwKoAyrc71ZV3Xcx7LsDkJsIm4F2H56uaxU5BKAqwtuUDwtpjZl
 tt3By3150inQNIaWia8fO4o99k/HFujhsWw8LoXgzLmNApVgtBglQxjOfnukbZUWmEll
 lT23YdopoLxoHwPsP6OF6paVFgypM7dnqVngSP7LgbW2N8nh+gEnHEToaTioHXcwbObY
 AYUl6duQ7tkaji/v+WsTqwFkYfG/eu9eiiC9ka+oqWOevY2ovOiAf06Di/TIX06Pj1z7
 /Df5iRli2Mf6/MJRWQ3KN2FzTN3CD1+ZbQgAFDyX/G0MrY4T+Y8e9hllKo+GW8xomLnE
 kLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331285; x=1773936085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJxsBIHex8kkMZ9dPlivoJgrHpKPpVcW4rflydP2WQ4=;
 b=hAfhJ3ZMId+1AyVe2Sr7vEbClo+WgNhbtmaiNMAgGxX1bKA4y+9hGWFRFNp37kiHPl
 cZwZjFnmlAIl3xvobq0LkpojBxB93jMDIfPHR35UXWkdyH2UShSPXw4MFaagfns06CQZ
 5Zqo/Hhl5wN+lOf2kb6FwVR9BcaYnbQ0A2Cw9WWF5bmz74FDAPwHRrW/jLRd7fRQDkmh
 F3vZv1AJWufiiQaIAZQwjfMl0hPdh4Q40fFEDHI7ObDGzPX9aql7dJvPza0Fhmu5YkHN
 zZGVM2UwE3RmyiPggSFi8wJ/OvFNtPZGM9rBzQGu4gGA0WbBl/2ZqPTfN90UmWu+Bt4S
 E9wA==
X-Gm-Message-State: AOJu0YxBUjhlu8PPDK4Ijm5JeSfHbC09HEFDBACxbULn4jMMNgAiS8TB
 YDhKg1eo4ao6h2aVra8xJPXZmCM++QxNlKLEu8rmvi7X+7D3eC3gefBAtTuMa7JsrHQ=
X-Gm-Gg: ATEYQzxXBiRma2flR24+OHcp710b4gmri96MHnz0o4frJ1m6oQVx9kJuxPiCyskCVlN
 /hING8zUa/HtXKDTCulnLRKPuQFGr/cOaUeqmLMIcYTLPn+IBfJ44TnlbBe6qxDHLiIn+L+W/ZF
 MXZhWQqjtficwjWNwB1nWMUfpAjT8z5d9MEk4huzADjfgo/yo8QqyZvaMNThOgqymVwZwmsrZ0X
 8zQp2IPRGvbN+vQUqf1qgH0Xlo9Dj+M1lJ7efY7/l47hmOzSxfowkqBU8nb3T+u5t3Y0oYIj02S
 0Wc3J41maLURb9TjO1Jndqi+t3DjHuTizwb2IlITmrsAjBp+WtTkYL/9nsBqlgcaRzVYDkaKBCc
 8l8J/0QZO7okPPtZ04WjCDpB4tKcIkqFtzo+oVDzDJJ/AQtM64GV4nKsTwkBLFvcqfR39WFSZQ/
 TsG6dDsBewzPTB8C0o97qJoeWYciNyh3dH5Ho=
X-Received: by 2002:a4a:e914:0:b0:679:dd87:3bb6 with SMTP id
 006d021491bc7-67bc88ae11amr4518327eaf.22.1773331283561; 
 Thu, 12 Mar 2026 09:01:23 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9332686sm3438846eaf.13.2026.03.12.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:01:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:01:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 10/10] net/mlx5: add rate table capacity query API
Message-ID: <20260312090119.791fc185@phoenix.local>
In-Reply-To: <abLWPxI8j49C2voo@L30177.local>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-11-vjardin@free.fr>
 <20260311093540.5ada20a3@phoenix.local>
 <abLWPxI8j49C2voo@L30177.local>
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

On Thu, 12 Mar 2026 16:05:35 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> >   
> > > +	if (!rte_eth_dev_is_valid_port(port_id))
> > > +		return -ENODEV;  
> > 
> > Ditto checks for port_id should be at ethdev  
> 
> This function is a PMD-specific API declared in rte_pmd_mlx5.h, not an ethdev op.
>   application -> rte_pmd_mlx5_pp_rate_table_query() -> mlx5 internals
> 
> Therefore, the function must validate its own inputs:
>  - port_id validity (via rte_eth_dev_get_by_name() / rte_eth_dev_is_valid_port())
>  - info != NULL
> 
> Adding a generic ethdev op (ex eth_rate_table_query_t) for a concept
> only one driver supports would be over-engineering.  If other drivers later
> expose a similar rate table concept, that would be the time to factor out a
> generic ethdev API.

OK, but I have a different point view than most DPDK developers.
Allowing and having driver specific API's in the first place was a mistake.
It encourages one off API's and makes applications locked in to a specific
NIC; which is good for NIC vendors but bad design pattern.
