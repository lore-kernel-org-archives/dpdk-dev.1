Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C889C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 19:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B258940395;
	Fri, 16 May 2025 21:45:18 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 1E95C402D1
 for <dev@dpdk.org>; Fri, 16 May 2025 21:45:17 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-742b78afa2eso64207b3a.2
 for <dev@dpdk.org>; Fri, 16 May 2025 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747424716; x=1748029516; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxV1042PHY6pjFlolqPD4/+sdiQbaq0IGjVpYk/fLvk=;
 b=MBXKtTtzwhZ3ILCIcHudoFD9D4sKvq78EYukecDpKoG7VhsRPAUxhz5Tvhsoi7DsCx
 X0Zrk0ILgYTak7UyVPVhAsyfZuMDBsLzOSXlDpDpZvwu264OC0N1DMwADYIrBMCvGmgP
 2GxUSP7+HUI3P5S2vwajDabC+/VgxKvcvC3Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747424716; x=1748029516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxV1042PHY6pjFlolqPD4/+sdiQbaq0IGjVpYk/fLvk=;
 b=WCWrDF68W4n/j6vuL8H7esZTs8m2kCztMFoGk+X6UFreeFm8pXKQdUdEMwPRnvguhY
 FuzKhJCTWO7Eh8qYbapFcsxASRN38Y9EKB9C9P6bWm0jxxaVdTlWZosoi3ilrDfj3OHQ
 8oHWsx4JhH9Z9LiUzelKBq/5EAYgTsyzej+jeSp7s+xg1tlWrPgb+CQjfqb2K9YvAln0
 Ouo7c2YM+QTT3g9r2ntwAZHxBJxXSloyPyokg+P2PFM27i1jitqgFNcZ+/13s3jwUQnU
 nQTOn5DcgIGSfqdtxghGVD4OxEaXJ6AO/lImBqmJhk/NXHpAbgCA/oE6bVVTUBCnpb04
 k4Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW40Qmn3Q1O75IJcABQCMbi+txPC7UQQscc3uGizpMJRMBK3iCuZm3V95hne4s2wUhgz+M=@dpdk.org
X-Gm-Message-State: AOJu0YzIzBHTbiupxOwU0pSt73BaMbUV95t3Qf24T8AieqExr9Bxdspe
 TrNgVRtcyyFclgkJk4aMDocw1juIXjESvxBpaUzNepC2l+lfXM8E9mMx7cF9TKPcdWVVJX2kp7T
 bf/bGtG/tpWMCXM9265FIErdtv2BP7KJlH7Jg7I0glw==
X-Gm-Gg: ASbGncv8o98BFpBIui0xN+eTaGoBEveM/0lWcmo7uUSmBAtaHR14tGyuU+kryln1IDI
 iBbPbNkSMYU+1SCBendFF4PGXrHGeq0iXu9ak9LMfsR66G90TtwhJiQbVqdEaC43AgF9KOWlv6J
 YOOjFz5j3utMj9Hoa1kVATkkwGlTQdySxmZ4drY1+Y79ySt0KtLpqD45LHQP1QGmP2Bjk=
X-Google-Smtp-Source: AGHT+IFWpqvKiOLv6i12BB/t7LmkOBkMClRPvLASqdpSp8H5Zd7ZWvmcgTUlfonLW8g8MzSie5oAdpEYFZd4vjVhIQA=
X-Received: by 2002:a17:90a:e7c2:b0:30a:a51c:5f48 with SMTP id
 98e67ed59e1d1-30e7d61b412mr2577045a91.8.1747424715970; Fri, 16 May 2025
 12:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-5-npratte@iol.unh.edu>
 <CAJvnSUBt4D=jvYcbZacN1kDXL6pmukVeVq=g5XbkvwPG2b4tZw@mail.gmail.com>
In-Reply-To: <CAJvnSUBt4D=jvYcbZacN1kDXL6pmukVeVq=g5XbkvwPG2b4tZw@mail.gmail.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 16 May 2025 15:45:05 -0400
X-Gm-Features: AX0GCFs3-0LTbOBJb2REsPtdCAIY7jvsCPPFkkcMJMjwHkx3QfM95Yvu6Xf5U3o
Message-ID: <CAKXZ7egtJKm_U6ZdRU4s2bD60Oh+u-AisigYS1-7KyjF1SaByg@mail.gmail.com>
Subject: Re: [RFC Patch v1 4/5] dts: add trex traffic generator to dts
 framework
To: Patrick Robb <probb@iol.unh.edu>
Cc: ian.stokes@intel.com, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

>> Implement the TREX traffic generator for use in the DTS framework. The
>> provided implementation leverages TREX's stateless API automation
>> library, via use of a Python shell. As such, version control of TREX may
>> be needed. The DTS context has been modified to include a performance
>> traffic generator in addition to a functional traffic generator.
>
>
> I think the statement is that only certain versions are confirmed to work=
 off of your implementation? I think usage of the term version control is c=
onfusing since we are just talking about using particular versions of TREX,=
 and not using a "version control" tool like git. This is more about listin=
g approved versions of the dependency for the TG.

I can fix that!
>>
>>
>>
>>          dpdk_build_env =3D DPDKBuildEnvironment(config.dpdk.build, sut_=
node)
>>          dpdk_runtime_env =3D DPDKRuntimeEnvironment(config.dpdk, sut_no=
de, dpdk_build_env)
>> -        traffic_generator =3D create_traffic_generator(config.traffic_g=
enerator, tg_node)
>> +        # There is definitely a better way to do this.
>> +        tg_dpdk_runtime_env =3D None
>> +        if (
>> +            config.perf_traffic_generator.type =3D=3D TrafficGeneratorT=
ype.TREX
>> +            or config.func_traffic_generator.type =3D=3D TrafficGenerat=
orType.TREX
>> +        ):
>
>
> We have this from the testrun config
>
> perf: false # disable performance testing
> func: true # enable functional testing
>
> So, use if testrunconfig.perf =3D=3D true?

I see what you're saying, I can make that change for the time being.
My reason for explicitly checking traffic generators types was that
any future implementations may not need a DPDK runtime environment.

>>
>>
>> +
>> +@dataclass
>> +class TrexPerformanceStats(PerformanceTrafficStats):
>> +    """Data structure to store performance statistics for a given test =
run.
>> +
>> +    Attributes:
>> +        packet: The packet that was sent in the test run.
>> +        frame_size: The total length of the frame. (L2 downward)
>> +        tx_expected_bps: The expected bits per second on a given NIC.
>> +        tx_expected_cps: ...
>
>
> "The expected connections per second" ? I think you just missed this one.

This was ultimately removed from the final version, incidentally. But
the way this was implemented does allow us to check this data.

>
>>
>> +
>> +        Attributes:
>> +            ports: Related ports utilized in TG instance.
>> +        """
>> +        super().setup(ports)
>> +        # Start TREX server process.
>> +        try:
>> +            self._logger.info("Starting TREX server process: sending 45=
 second sleep.")
>> +            privileged_command =3D self._os_session._get_privileged_com=
mand(
>> +                f"""
>> +                    cd /opt/v3.03/; {self._tg_config.remote_path}/t-rex=
-64
>> +                     --cfg {self._tg_config.config} -i
>> +                """
>
>
> I know this was just a work in progress for RFC with some hardcoding, but=
 you already have tg_config.remote_path, right? So, the leading hardcoded c=
d does not do anything, and even if you had to cd there you could use the t=
g_config.remote_path?

Yes, that was hard coded as a temporary measure. The cd is needed to
ensure that the TREX executable actually runs properly. I must have
just forgot to switch that back as I was working with haste.
