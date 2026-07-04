Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21268C43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 16:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24E0B4065A;
	Sat,  4 Jul 2026 18:46:06 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 63799402C6
 for <dev@dpdk.org>; Sat,  4 Jul 2026 18:46:04 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-37e0a189b0bso1014024a91.1
 for <dev@dpdk.org>; Sat, 04 Jul 2026 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783183563;
 x=1783788363; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMA565bQsNGhFUvTQoClY5WwJpHoQcIakf1/O0Y02IM=;
 b=raM64yAowOLCZnd5B3C0K+2Wb6HRgpDz0r3yNf+BKuKE32oeG+zQvqa87PMnY1/+ro
 UVV089A2HXPLnm81fFwewlm+dPcAUjcDsv48dGcpEx+C+KPiVwQvekTIy9+f65lRbSFf
 eHRFTzU+e0h8qlqb3MTDyej1C6tMiW/koKgQlv06UyZLrM2Z1IZpJrwE/+Nq5+XHMyKD
 N5+aGW1D5Az6qebNFjNGYNSfY46WUBzrEKZPhpGT525sUB97fpA3DXCRjPAo07XFng6/
 vgzH6JwvLX8ObH1u+/i9XqqWHxySK07T4hSR7WmYR6W0GrUbZaeI7DAcqeIb6DfjbqiF
 TWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783183563; x=1783788363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BMA565bQsNGhFUvTQoClY5WwJpHoQcIakf1/O0Y02IM=;
 b=cirM8Z7PGSGotwF2sMCwDSNhXLNBAvTi1XaBV4rZjg9AncI9pQZAwTo/tImcIFNLTC
 Kc+uQ62B4jPE/b9c3ccmt0Agmc6VraCzX+6Xrzq1AFEMb5184h0WVY72g1/TSqS6d9ey
 LaBuZegJoDpUsROd18wbAci5cnOyx7fcLaEGySem/fKL566B7AH+QR2b1SoBb1fWlxx5
 Qgi4hiPj22KJEyqY1kM9neNcDK8Xewl9wpM/z3tBlA7dNop36UZhUcmnLpu2pt4Ou1vQ
 mGabWOvtNPDSZ43xw5niiANF+rAM1m7H3jvO/H64wxS5ioomBBi/mkjOta0Ku+loTHZZ
 2Xig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rorbo+kc1qBrX9SS3BfG6H80i7cgrxdxnbJJQod40o0p6B2GHQBg56IIyflg7Ja8X32A5k=@dpdk.org
X-Gm-Message-State: AOJu0YzxGFbXHt6a3yo0rd6aZOAOG77EqdYOUO1kOX5qxpoaPXZj3Rpn
 D2WR1g4oAFU44ejAHvn/YL/LWXtKHWnV6kOgP/+m4OhuzTYllEYaa8HTaFhpyNeaY7k=
X-Gm-Gg: AfdE7cm/yw8zeNpPblw46hj/Q6YVUBsJwZLm/guAzpCXkJD/qdXvYy3EsQv7vMUbuQT
 BzCL69r/bNo7HTSHiSH/EVG76bA6xsOS8sEnDCCE30PE71XScWcB+5UVQWOJPSD+7ljdPSXn93k
 zcYruzlkwi3T+qh5ML0hBCAZV5nMcdVdRduNpK1OeGIE8aTWZK27KqT2Poc5VT1Bh+xNXj6PtD2
 zpkQGqOLlUzPKUHt7kjfflPHAlaHp9e+UjAcFbupl9dufRBUAoPCc3yAO6up9AhWXU5/0+3/o3t
 ymwQuBPeHYAMgCAdOW7JdWFZpZ8hDr0TmzpT9ee9R4070SoDvnEKOPHscuUVcTH4LdKApuQWewC
 Dqw+W+RfPDMBnH0iNlv8yt8fb6JYVvh1zUe3/+xbtBHaau9FkeA+tf2R5zr0baeQ9xwV4zSfTns
 WsNpsk0Ce+SGyjGKakSpWzVlYMZtBaL3vzxybCNo4QQXlhwQTiNwoQSg==
X-Received: by 2002:a17:90b:3c91:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-382934ec0c9mr3809340a91.20.1783183563115; 
 Sat, 04 Jul 2026 09:46:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f376bf710sm14186697eec.6.2026.07.04.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 09:46:02 -0700 (PDT)
Date: Sat, 4 Jul 2026 09:46:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: datshan@qq.com
Cc: thomas@monjalon.net, aconole@redhat.com, dev@dpdk.org
Subject: Re: [PATCH] devtools: support local opencode agent for patch review
Message-ID: <20260704094600.3dcf165b@phoenix.local>
In-Reply-To: <tencent_4A299B76E71AE508AF5D403AFDA4B248B708@qq.com>
References: <tencent_4A299B76E71AE508AF5D403AFDA4B248B708@qq.com>
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

On Fri,  3 Jul 2026 17:19:02 +0800
datshan@qq.com wrote:

> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> Currently review-patch.py only supports cloud AI providers
> (Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.
> 
> Add a --via option that invokes the locally installed opencode CLI as
> the review runner instead of making HTTP calls. opencode reads
> AGENTS.md from the DPDK project directory automatically, needing no
> configuration beyond opencode on PATH.
> 
> The --via and -p/--provider options are independent -- via routes to
> the local agent mode while -p continues to use the cloud API path.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

So most of this script was AI generated, turned back to AI
to look at this change...


Thanks for the patch - the opencode integration looks sound. The
--format json parsing matches what the CLI actually emits, and the
_run_review refactor is a clean way to share the dispatch. A few items:

Bug:
- subprocess.run() can raise TimeoutExpired, but only FileNotFoundError
  is caught, so a timeout gives a raw traceback. Catch
  subprocess.TimeoutExpired and route it through error() like the cloud
  path does.

Please clarify / fix:
- -a/--agents is silently ignored in --via mode; opencode auto-loads
  AGENTS.md from --dir, which you set to the repo root while AGENTS.md
  lives under devtools/ai/. Does opencode actually find the guidelines?
  If not the review runs without them.
- JSON metadata still reports "provider": args.provider (stays
  "anthropic" under --via); use (args.via or args.provider) as you
  already did for the token summary.
- --large-file modes are silently skipped in via mode - intended? A
  warning would help.

Nits: non-ASCII em-dash in a prompt string (use --); the trailing "--"
before the message is unnecessary and may drop the prompt; redundant
import tempfile; unused max_tokens param; f-string with no placeholder;
run black on the full_message assignment.
