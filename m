Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D22CEFCE1
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF2F4028B;
	Tue,  6 Jan 2026 19:05:01 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 6D5C6400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:04:59 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6505d3b84bcso1922333a12.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767722699;
 x=1768327499; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p/u13ZebHhayoTUntEUZfXVc6S570K5fsIR/miPXh0=;
 b=DxDUxsjOxL5KEIH9nqHkxp3r9ktnj3r+NqbFjcDkSx4k6Mhiwii4rOijiKXnl7QACk
 RetWwTXCWuUiFnNmKS14oOAfpVmsOJBPplvtlCD4gnWOBCDRVkgf7pGiFO02AL+/vzzM
 cCBUxuYx3SuMpPuLMJbnaQtOobwCH8zDG9r1bEAzHTO2L+hz4prdfuceyRpyDkmmpHWz
 LHhiqoo2LBCoNSvK7nryUPOZGDmZN+6talnrbUi3WFDXfomopqwknwX4KsS3KtoW2/8W
 R/X+tQFFPAqi9HIhnsraP++EaAMEWVublaLbSVOqJVSvZrv/n6OliikVbGxRmK68sXeh
 3ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767722699; x=1768327499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8p/u13ZebHhayoTUntEUZfXVc6S570K5fsIR/miPXh0=;
 b=Hy8eg/PgDlp9zaZj+5EfkcEN+R+sH/pXyLmaULfvDxPwLZlc6ZADRiWGe5hNR+GqWP
 qEVFafhsTIXkXYMhGWgFuxLCWCE+RdLXO6Ohg3FEza8yP7wNXseLEt7eXuFDe6QV+sZu
 czfETImUsLx9IJwc4qMHBNtMxFVYWWneUxaTpPS+ZUn+pwrf93T1OVcFGidnTOZ1kocG
 85kXJQfDZpiiEz889DyOAL+gdB/aK/9h63nhdZJ/Gr6iR38R6OV43nrFxGcMQfrqdrwO
 bfE0T0BwqAWI68QH6yi/TGYT9GRXqcsPbX4zDwZ0RZXkxDtzjp+SM6H3d2ayc9PvWtpI
 6ntQ==
X-Gm-Message-State: AOJu0YySPghrpLVNbLi4OEmdbLW+QlJ8hk8UFYYJzn55uv+nrmCRsDfW
 cQnXcT2DHNh3VpSkGALN7ASAWGXDei1I99WfgVzcqP8Mi5JOb61Sb5dcYjBp3Vd3dHq1Rw91Pj3
 eyaAegH8=
X-Gm-Gg: AY/fxX4s/+JSaXP2N4KNSiESS2TFAwjARxdRlbNz5/2kat/nFIxAPciUK3kaiyCGy5n
 BeZLxs0hTyM/msVgpca9DeWRD0hRAHq+DYQP/oHVFGUDHv67wIZoTMnCtUhRhXPTCvm0i5qUi56
 hbTHUIgTGGmV2Ae97Ng7RW4jCLIbM7mdmldapMfLxYoUDYpSLD4mDnIWNT+G578nYX3V6bh5jaG
 pnsJhIszt99CRwmO9X1ZbHhhvEHu1MRfPk6ALfkYEOabSeUz2HhUZOpofzB4hubI8+Z3w/2rVAk
 6kWZqQpYKpdIo32Aq7+kmszVvTHOvexfiD6t6Ok4l/blFFhtqYcfLZtJrGPf8Psx++8xhGGSx5q
 16GBXYhz/N6F/df2oGBSCm9iIGbWXId5kGU6nBMGqreq06DF/GrPX+JC4J1FrWP0EkJ6JK9gBUn
 Gq7J/WWr8bP+J/kCRpQRY3i7puM1L2/uYPBoo/T+ZaXfdYMCT0FD7q
X-Google-Smtp-Source: AGHT+IHCq92vfTOHRwgULnsv+vYau/vD5ymT7WPnfXKcZhKKxOggVir62ZysR4tabvYka5lEkpNpzw==
X-Received: by 2002:a05:6402:440a:b0:64c:fee2:1dc5 with SMTP id
 4fb4d7f45d1cf-6507967c184mr3632122a12.19.1767722698907; 
 Tue, 06 Jan 2026 10:04:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b9d508csm3036406a12.13.2026.01.06.10.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:04:58 -0800 (PST)
Date: Tue, 6 Jan 2026 10:04:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/7] test: add flow parser unit tests
Message-ID: <20260106100454.58ec550c@phoenix.local>
In-Reply-To: <20260106153838.398033-5-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
 <20260106153838.398033-5-sismis@dyna-nic.com>
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

On Tue,  6 Jan 2026 16:38:34 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> +static int
> +test_flow_parser_command_mapping(void)
> +{
> +	static const char *create_cmd =
> +		"flow create 0 ingress pattern eth / end "
> +		"actions drop / end";
> +	static const char *list_cmd = "flow list 0";
> +	uint8_t outbuf[4096];
> +	struct rte_flow_parser_output *out = (void *)outbuf;
> +	int ret;
> +
> +	ret = rte_flow_parser_init(NULL);
> +	if (ret != 0)
> +		return TEST_FAILED;

Why not:
	TEST_ASSERT(rte_flow_parser_init(NULL) == 0, "rte_flow_parser_init failed");

> +
> +	/* Test flow create command parsing */
> +	memset(outbuf, 0, sizeof(outbuf));

Don't think you need to pre-zero the result buffer.

> +	ret = rte_flow_parser_parse(create_cmd, out, sizeof(outbuf));
> +	if (ret != 0) {
> +		printf("flow create parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}

	TEST_ASSERT(ret == 0, "flow create parse failed: %s\n", strerror(-ret));

Or do you want to use rte_errno for error code?
