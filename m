Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D2C98338
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 20:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD6384026D;
	Sun, 27 Sep 2026 22:09:48 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 411CD400D6
 for <dev@dpdk.org>; Sun, 27 Sep 2026 22:09:47 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1235653a91.1
 for <dev@dpdk.org>; Sun, 27 Sep 2026 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790539786;
 x=1791144586; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m4hDx8jDZOnfGOKxPEuA7Un+NkQn0iyRksINHkUUKlk=;
 b=maOEmQ0qrRZuET7uvNMfogi6rHm27hULlWyD9fQjaN5/I/9QkjR0Jn6xAR9O0VpL50
 pfXgkssekmTfSdPmtK1PptWKZ2S7ieMPU1ElIi/wuLWxu4fMLeLphtguE49MRp3zKTqq
 w1UMHEE+nG1E3v+z0WYSriJLp5EEVbJAccRDgScPBdG7ix1UZilo6yWx3Y+GHRDJE7ha
 W3u66KZJPKy8vqKpQlSrZy7ZindTWdznTTnNZQeO0mt/2HGkD6eW64sQCJXI0ujnfwgU
 MZL7AhATHnZc8XFnrfIvJ7JKgqHVRISzXufaTM42emj7SpqQbuXimv22kJRapw5RdZ2y
 qwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790539786; x=1791144586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m4hDx8jDZOnfGOKxPEuA7Un+NkQn0iyRksINHkUUKlk=;
 b=w2qjuM9H9/nFJTRLKDpL/QctNLWXrFDjGCv4vYT/X18K62/v0wlPKufuv3AIF49gFB
 0IOWeFsV4YvxDwWSTwnGo+FRE5AKlHSxitaBnf+rLtcVjgUBqGYdj0098vrJO0kaHml6
 z++rQyYNsILSMr9IzYVZC19AU5EOafMf1nvLezkSZDB6LuIM2YPPZbVKEiXBZvaCU6Rz
 m96zOnIPgeUANWkumV4vM/F7y1yAYV2NH2uLx8JLqaDJm+/5SOfxLvYLXnwqkHTHZFD4
 Cn7sNCiVz9fR7Lw7ssom0hz+f8PIiWRcG/gVhpAm411nCu5s4bvzQtD7ff44dAJa3COa
 LvSg==
X-Gm-Message-State: AFq9FYLy67YvSCdNG0DrJbiHEp094rlnroyhWsTLOWMT+Zc51CtkBS1P
 k9RFvEbjl9iXcFxhqC+Yj+Jj9rnUYaK5Gi6FalXLyfE3NTjqHApH3ZQlpNr6+P01Lx+tR37e9uH
 WSNaLfNg=
X-Gm-Gg: AYBFou0DtpWOK3cit27WvYcg9bGKWw7MV0c09Yg1EiA0Xg1zf61w+QQlYT7CGwkwcfI
 Sxt/CAhkEaMW6wEDNNZXzlpgiu2yyM5VNJ+OTWMtQNokfh7Zx5VSNmgJxA4mZHOFgl9E/CMwOMS
 8H6dZXPI+5jOCSWpBm5dkF0MyOl8JPvWlKOGKbJi/RyXA5+mPBiQjNYyM4IQSfdIOxuxUH5i9Jn
 1npkZt7cI11tonu/y4jgTism7hRWE4yL9ANPWBqPwnm8DlpUoEeOtZhpZ3rzHgZm00GeBISy8E9
 4ugC/3E6uLutuz+z65QsQr9l/CYErCE8q5A9cAQSeiYMltaU8lFBMBY5rKnzG11gbZFqRjZAYt/
 +wazAa3SFJXk2eKhxlNmFhbHdobECP+yOAZGKZ+CTVHlx5rCayutMdfLmdvN9G9Hwsogl+7vwl1
 D/deq5TBqDT5TgjE0Czeq4ufR/1fnpW5uI9aRvCclQX/86lQm/aKI60mDYILpxD905yPDBfGX5Q
 wlSaYpBCRSqpaMBaODqMWEtuRqqzv+HIsgG1qFM
X-Received: by 2002:a17:90b:5183:b0:39e:6c68:fd96 with SMTP id
 98e67ed59e1d1-3a098b98996mr6912642a91.43.1790539786136; 
 Sun, 27 Sep 2026 13:09:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b94936ddsm16359902a91.7.2026.09.27.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:09:45 -0700 (PDT)
Date: Sun, 27 Sep 2026 13:09:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>, Ravi Kerur <rkerur@brocade.com>, Thomas
 Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] eal: fail initialization if TSC frequency is zero
Message-ID: <20260927130944.6e3d8f4b@phoenix.local>
In-Reply-To: <20260927195440.89193-1-stephen@networkplumber.org>
References: <20260927195440.89193-1-stephen@networkplumber.org>
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

On Sun, 27 Sep 2026 12:54:40 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> +	/*
> +	 * Several get_tsc_freq_arch() implementations return zero when the
> +	 * frequency cannot be read, and a TSC that does not advance at least
> +	 * once per second measures as zero.  Such a counter cannot be scaled
> +	 * to a time at all, so fail rather than let callers of
> +	 * rte_get_tsc_hz() divide by zero.
> +	 */
> +	if (freq == 0) {
> +		EAL_LOG(ERR, "TSC frequency could not be determined");
> +		return -1;
> +	}
> +

Sorry for the AI generated comment here. Will fix in next version.
