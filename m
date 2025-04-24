Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C416C369D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C8F4060F;
	Thu, 24 Apr 2025 20:36:31 +0200 (CEST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 by mails.dpdk.org (Postfix) with ESMTP id D05C64060F
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:36:30 +0200 (CEST)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-e573136107bso1138446276.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745519790; x=1746124590; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=QxcRlUWkr1GbrWWdzgPeu0/CwaLKXHNcYoXOS2OPhzwbOHm8mdQtujh5DoNOErOfpS
 ntHyqN1ZXb3wcjvYOgqzjEWapLg/eRAEOR4/U+RLDZpAdKbZ4EZMkUWAPdLuSrlkMO/Z
 lCkB7ssNThqn+qFUmtolLuDnn7c1aX01Jwp0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519790; x=1746124590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=GYct+U5kBuEofzM2f9MaOyBYTe8pYggc6G76Rj1T2eoEpOVI8mIp4ppEV4S0AyTrvI
 xh997FMr24eHpkeIJRpcaYLdZelqrFufG64iTgw+sFGaBkXDKkNfTtAt4rl80jIwmo38
 xb0k4JViL0jV+wAhkIf4lWwwi4VLqw+6uY0VwZYmmc8gEvTfSnz4v9N9KNl49yr+aEJU
 QPfdLJbL9yKmJn9o+RVc8x9CsKLWX3s6D/7411skN3ucQX4CPDX/DBVJl0h/hnb3onIi
 55Wym4G1BfT4g24kYnotS8jMi14YlPpeWS1a0gb9R4l5ffLCdJhYA6PnQdJEarVoBfKP
 fLUg==
X-Gm-Message-State: AOJu0YytZzVhJfe0wGkfPJ2sf3RwQv2oAhhyIG9rwl/wwQFe+N5ib1yc
 OesCyU44Clc6kwN/YaAczDBmM4ayZ6Szqj2wZZadeK899R73jjpC2VvIq7V6I2gyCrJV7yPs6JW
 VL5agcHKYcffhV+RyzCTRCiWdMrHi+/Aoh/88Hg==
X-Gm-Gg: ASbGncuVQh41t9oecHx7FWXmxwWBGqgzSaBh/4gVhSFcnpICAZ5Em+213R9g7JKPhXU
 mpE3gnHVnhNx07vdjKhIEEu5at7HnP+06r6u/GELXgjnWaQuZiEhI9K9f3IGck88JFtpTg+rTsq
 RpMORu404XehnTVjCFqhWLghdC7zSv6JjL2meOyoXxQDCjnBtUH7YgNY6j
X-Google-Smtp-Source: AGHT+IG239XfGwY3xk9ITxFnNgpg630hkOSsbmVlwSKMMGUJ8DxZlxjlV7k9xSIT5ldla+n1pPhihoSr9TTxqjusdmw=
X-Received: by 2002:a05:6902:1ac3:b0:e72:d38d:ae4d with SMTP id
 3f1490d57ef6-e7312eef06fmr651330276.43.1745519790152; Thu, 24 Apr 2025
 11:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-7-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-7-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:36:19 -0400
X-Gm-Features: ATxdqUFoBkSzzp1CGBSpmbJL6LziCiyGBA5rFjjTb5dyCcog--dDNV9oZZEk32w
Message-ID: <CABD7UXMFnfU+WCTS9-NK_CLo744fZfVz5himwZo3hpypqqeHTg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dts: remove multi-inheritance classes
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
