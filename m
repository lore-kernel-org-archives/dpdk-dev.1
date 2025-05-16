Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25964C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 19:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5386140395;
	Fri, 16 May 2025 21:12:59 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id D13C0402D1
 for <dev@dpdk.org>; Fri, 16 May 2025 21:12:57 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso290566a91.1
 for <dev@dpdk.org>; Fri, 16 May 2025 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747422777; x=1748027577; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mvh5qZEna+ULiIk5Re73WTFSShpPsK4J4QU6vJhrFMI=;
 b=bJ49PEK8KpUtviPPH616iFEgrYW5H+UgoVCXfMtFyEGHxvRaOqCIwVjkDgoTnfJDhI
 xJ0xFTXBS7E82W362F2OkjZcllkdPMw4AOojYDForOyluX2gtx2uzuXkLbUpGO4zToAA
 FQgXCWwSenTbMtcsC2M1pK0iGJNAtazIDsoG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747422777; x=1748027577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvh5qZEna+ULiIk5Re73WTFSShpPsK4J4QU6vJhrFMI=;
 b=IcovdM3DtvpPTmQoryQsb83PHQle1Qph/TY8B0Ts2d0JH7QkTLCnX3OUjstYldjq3C
 9KMIxrl87GtrOLypKgTCDVraKwK00IQX5nj/yWh7CdbUnITA8ujfUL3og1fO+y+3SQ6q
 DK3j3hCnzEJtgyB49gWkMfIK7Peu7AGLitpu4T0wqzR+QfSy/Q48kbrSaCeUfDMYPmlu
 xJv7CLEvGeRh9p8r301q9imioTKa7cQ9tCqcJNvouSEaZUCXjJ7BmsRGvuD8sqOWgFrA
 SmT3UtmbK0lp/d5t6dWqCSh7UlMMT+T+oPj4ARseJMEN74m2AB7WhvsR1muU6Vigj7io
 XaGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWd74H1WMSde2/89PgJO0OgkTYYh7nTR2pNldU0KQIRtFElV3bj+fXF5U6wOpmGwchR/k=@dpdk.org
X-Gm-Message-State: AOJu0YwM4+ivgScVT0CrRLIMK/NrCSUF7X4tfEMbqWy1TREQ8Yq/0phq
 4crdGnWVR6zj8ukZJk4oYOPXt8sHJvnFJRR1aJecwQOVsZW4yB5Q7gromWbcrKvWFmTNmDyWVvS
 0mg9kPLp5YFRiWUyczD+qbGOyRyeSX2qDXK07cS83hw==
X-Gm-Gg: ASbGncvg+zqF4rg/GwtvSUFfaHLlmrFPZJGNPFjEZba67PT801yhjXY62UgrAo7wXjH
 nHHWcYiUAA79OWXBfTEOEuKb9InU3EccGzUeBw8KL3VJU3vwyRbvxoH25FWBoCKjG6aZzhtmhC6
 QR4twPwRZkxBp5LRlYKzblBvTuvvdWKwyzmYhiBfKg/ZUN6FOgMPe3s0e3nc8MjYOaWAA=
X-Google-Smtp-Source: AGHT+IGe4TxIY49Dx2cL8WR59EO3MDRRm7pKgq+CuYOIblIg+wVJtHb2iFrIr6JjPIlCNpQOhLbh3j7JkF3ItTQC7Zo=
X-Received: by 2002:a17:90b:33c2:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-30e7d5eff12mr2355616a91.5.1747422776735; Fri, 16 May 2025
 12:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-3-npratte@iol.unh.edu>
 <CAJvnSUDs7To7F7TBH+CPn39TwFK-hu3+jzm_DMcEKxtDPqvYyg@mail.gmail.com>
In-Reply-To: <CAJvnSUDs7To7F7TBH+CPn39TwFK-hu3+jzm_DMcEKxtDPqvYyg@mail.gmail.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 16 May 2025 15:12:46 -0400
X-Gm-Features: AX0GCFsvclh6mVW2MrYfU-7gOg81zCsFQlMJfIfKXrcNOjZUaXj0rtCsh_8p6to
Message-ID: <CAKXZ7ehup4XA1T99BjBsKX1a30oBgT1pkg92P-tP8E_RZneQbQ@mail.gmail.com>
Subject: Re: [RFC Patch v1 2/5] dts: rework traffic generator inheritance
 structure.
To: Patrick Robb <probb@iol.unh.edu>
Cc: yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
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

Hi Patick, see below!

>> +
>> +from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
>
>
> I think this can become:
>
> from .traffic_generator import TrafficGenerator

Ack.
>
>>
>> +
>> +
>> +@dataclass(slots=True)
>> +class PerformanceTrafficStats(ABC):
>> +    """Data structure for stats offered by a given traffic generator."""
>> +
>> +    frame_size: int
>
>
> Do we need to add an optional number of packet descriptors attribute? I realize that is a SUT testpmd param, not a TREX param, but presumably when we gather stats, we want to store the descriptor count with it.'

It could be done by passing another parameter when the function is
called. Maybe adding these parameters is helpful, maybe it isn't. It
might just be easier to strip the frame size and descriptors away
entirely from the statistics data structure, under the assumption that
these fields would be managed in the test suites themselves. I think
either/or would be fine.


>
>>
>> +
>> +
>> +class PerformanceTrafficGenerator(TrafficGenerator):
>> +    """An Abstract Base Class for all performance-oriented traffic generators.
>> +
>> +    Provides an intermediary interface for performance-based traffic generator.
>> +    """
>> +
>> +    _test_stats: list[PerformanceTrafficStats]
>> +
>> +    @property
>> +    def is_capturing(self) -> bool:
>> +        """Used for synchronization."""
>> +        return False
>> +
>> +    @property
>> +    def last_results(self) -> PerformanceTrafficStats | None:
>> +        """Get the latest set of results from TG instance.
>> +
>> +        Returns:
>> +            The most recent set of traffic statistics.
>> +        """
>> +        return self._test_stats.pop(0)
>> +
>> +    def generate_traffic_and_stats(
>> +        self,
>> +        packet: Packet,
>> +        duration: float,  # Default of 60 (in seconds).
>
>
> Should it be float = 60, so the default is coming from the function, and not a "default" which is coming from the testsuite? If not, I guess the "default" comment belongs in the testsuite?

I would say the comment can be removed. Right now, as you mentioned,
it is set up so that the default value is asserted at the test suite
level. It might just make sense to do away with this default value and
just insist the user explicitly provide a duration. That would make
sense in its own right.
