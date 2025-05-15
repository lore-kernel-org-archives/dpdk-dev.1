Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D0C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 19:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 660C6410D0;
	Thu, 15 May 2025 21:54:37 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id C7C9C41060
 for <dev@dpdk.org>; Thu, 15 May 2025 21:54:36 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-70b75ba2fb5so13166307b3.3
 for <dev@dpdk.org>; Thu, 15 May 2025 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747338876; x=1747943676; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JCu/axfGGP4BtGLS7+elkD+M0yfnaX06re9hnwSvloE=;
 b=PL3iB9jyQ1XBXlC4rKsL/KTIbqBFRYk6lPlmxfY3CvVH8uFeWw8315PyDf1LmL/W9e
 hwa2V5yVoV8DY9RwjgExjGYRalTATbta6L9CljslUn75v+F+PyvYNDZdWJu17bf2D0Bh
 dexMuT56w7h+haPrgtRxEB2pRuHVxJVYBRceA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747338876; x=1747943676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCu/axfGGP4BtGLS7+elkD+M0yfnaX06re9hnwSvloE=;
 b=WH/gLOSorWfDRRD0L6UKGAsKRrslFImsQXajrCaYrV9ARq9vPW4ukS1Mxu4bV3ihh3
 ZzB1uJCKKKgUU0sE9Zql5hhY9YXtIXC5F+qw58kcihdGlOp8fDUNhApIV0ONw8LWdBxe
 rksUOOjXH7zwSzQwukE3lSwLW7ahAGXj7vf5yluXcUEPL52cNSq7CyCCUpUNptne4Osa
 +oU1vJc1+qv5T0No+x7BeeSqKjHofpi3CWsLKa3PHYX9IbV4+9ol/GIgpZvEvUCsLVgK
 j0sXUSXGS8Fih0z/t19LKVEQjFwi9PdltqCap3fyQ7k/n8/+K/mlGraORz3uYvSFsUrZ
 M4Jw==
X-Gm-Message-State: AOJu0Yw25u2USiUBQN73FULXDef1bJqbDYBqdzejQ6eeq31ZBAKNHqxm
 v93PVtyV4h7gX2KLiOb2Zz+/ipOUwA5AmWAJOikQb/x9eZuPi7v7UBVHtkA1wqelmn+uc4+YBGL
 PRy/gvW2Ldf7na0GZz4P2Eggy8+X5V9rB6Stn/gKt0w==
X-Gm-Gg: ASbGncvjFhTRWp10C6qQfXxSXDjZelOsPuhD7jnaOZuA9WV/r01QMsBJqb56wi033fT
 qCmlvhoOSwG98D0znSFO6Apcy8UpmcXx0IQAIDOl86HDK2MEeiRsnN4vlu8bCNVoeOE2Veo+CHs
 QxVzggsF9kEwiiRAQr3o75olvf31Mi2/sX/YQS6mn9AtXwmutYCXGxSgcVbQ5SQk4TiEo=
X-Google-Smtp-Source: AGHT+IGw/XFIXzAt2USGEKklDFJpIggZxgHlcB5+arITIoNaNiwzKH8iR/WZRJagnGRYlIpbDpy28vlxVLHwEuZSfl4=
X-Received: by 2002:a05:690c:2789:b0:702:52af:7168 with SMTP id
 00721157ae682-70ca79a5e12mr19592417b3.2.1747338875997; Thu, 15 May 2025
 12:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250506131657.1576152-1-luca.vizzarro@arm.com>
In-Reply-To: <20250506131657.1576152-1-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 15 May 2025 15:54:25 -0400
X-Gm-Features: AX0GCFsKB2q_DA-zBmB0HVz6xpus2pkVhNaRW9gY9D-vO6kQOnNxa7A92a5V6UM
Message-ID: <CABD7UXOs8AHzrCxjiQ_sZ+NweAFo+hsHPYiq6wMhBGzpiEF7VA@mail.gmail.com>
Subject: Re: [PATCH] dts: improve port handling
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

Looks good!

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
