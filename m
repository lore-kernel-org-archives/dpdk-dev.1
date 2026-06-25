Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE4CDE00B
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 23:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3863C40278;
	Fri, 26 Jun 2026 01:12:28 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 181AF40272
 for <dev@dpdk.org>; Fri, 26 Jun 2026 01:12:26 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30bf132969bso627969eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782429145;
 x=1783033945; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY5t/easyXhmAAmow87pXxZQH09rD55k8phFjhoBefs=;
 b=Woj1xk/zd3uXHQJkFrj3FaTvRzSItuHcj5NEBhVSHiam+NnFPR7QdHy1qhiAO8jPbU
 hZprQIhRLKzoUhwcOLb20iptysYgaXl2Gr0uwSvYvKb9pCKdeuG+KzxqONBbVH7Py77a
 VSBrsfNy3LbN3fQjeqSNJdP9zIUlzrG28ua8X+9NtVke7muuN8oYD9xOEExf2qe37c96
 N6xV7zajsvQcOC3bPlVq+BnWAsUItipYa0pORyl7pVZxkOwbVKTbnOHqyp0nZKHU+dGZ
 P6dk7Ph26qeT/Z9aDnNEzWq667zlXz2slAtMnB92WjXaXhBHjzt15ZxZDD8pKufbxy/c
 mStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782429145; x=1783033945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xY5t/easyXhmAAmow87pXxZQH09rD55k8phFjhoBefs=;
 b=LSA56O+ts+pWY0jPwnwfo5vlb3fVaXPjyOzQ6li7y5VuQwD4yXxYRwboQtIx7a8gfN
 //PCLqRuacbXYon9kmnISoglKjYOHDxzrNolP4yi58h7xF/lUEVRILbbyIBVe/cJ8JeE
 EOffBShN1KCYaOkJGeSmgzbjrDloJ1gnbRZbrub9NQFUcoSmAcL4dG3NxNBgbsQ99LL+
 DZ+1+T6oB3yWn+FaoMJztbUkbHnsrEugPp0IcNMIdY/yEC8bylNZP9fIBOGYElshP2u6
 q9VTTLpcSZYv6JbfEzKoShXmJpbMRUdC+PqzKr16BMLsLbTfWIlTzKCpOxuFrI+TYqBe
 PwAg==
X-Gm-Message-State: AOJu0YwfoeO7WgORDepUeMilGKLvDi52qLo/ZV+GqXWKlJ9DHaGnQIRX
 Vjvq0CmWYgyWqtAmfExc7SkGoGMuDnVxahfaASNqu/kpJIznDM2JjxS0g0hu8TYSbmREYE+BP4h
 Wv9Pt
X-Gm-Gg: AfdE7ckAgEvmK8p1KHnjwkjPMraa6koyWpx1Bv9h33Y/yuAFVfycT5Azv7YlcVRDXkd
 S8PG0wiczdhouyuLMMgbi24I6NH+oQAb+OR1WP+R91Os7hMgykocEJaAi/NSd/5u+TeZahaPENa
 CWF/pr+eSAOK9WEaWdM0273nO5Lrsd1g8w7R2NPqCK3FWRdm2Qcuf9VqLwGGEqXuNzyGqF0n18m
 T8Wx9O5sMIbOOvHzOB732yQ1Mh1Wg3WuycxxOZhOYV2R7DhGs3BkoCNG4w03PxYgsndOc/gJudA
 y3X8tMLbk4qhU9EIYP8n3wy7o7h22hY21uDj2qFie68nvGZ+AWdTZXjL+xeeDXs9/MzscihPLXN
 lq+2Jfj2gyMFEExyCdxrTnjyswCGH49fPTuQeszbJRcbXcQgPwClK4wlqVKwAXscZDKY9CMZjaZ
 BQ5pmSmZY9lfMylHO4ZjbKRyZCRO5EKaY+LUxspwudJpEZ0riL2o51DQ==
X-Received: by 2002:a05:7300:1488:b0:30b:ff0d:1efa with SMTP id
 5a478bee46e88-30c84d9b4c8mr3740850eec.24.1782429145069; 
 Thu, 25 Jun 2026 16:12:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c944999adsm3920015eec.24.2026.06.25.16.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 16:12:24 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:12:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Marat Khalili <marat.khalili@huawei.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v6 9/9] test/bpf: check that bpf_convert can be JIT'd
Message-ID: <20260625161222.06cf9307@phoenix.local>
In-Reply-To: <20260625173231.216074-10-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
 <20260625173231.216074-10-stephen@networkplumber.org>
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


Recheck-request: github-robot: build
