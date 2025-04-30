Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC6C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 18:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A01C402B1;
	Wed, 30 Apr 2025 20:28:56 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by mails.dpdk.org (Postfix) with ESMTP id AE95E402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 20:28:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDZFiQTA1LVGKDm5QySUkeoKAGFdEMQ4/MqlGf4MxM+mIwHo2C+0YGT2VUZQ6TNZMDv+f9T1gGnxqSUGvsEJLfnWOag2gDh+sSa5iIo1nKJ9jQ0TpepOAjI1meMnu6CDSVlBWRa4fwi1o9oLmfVtCS8Ou4WVdzxupQXah+DXCMXeRZYk7tiFtVRsAM6eUlJIprPanCVg4VDY34Q8lrZ8tWd/Ihgs6jAY8jgOXyWM70UH6bQQV5D4NadqFlqxM2GW0g5BpnbcjJVUOC3aUm58zdJp4Id/6s5xInUpYkypjQcfNJo34FIl+cdoqwDKfP1wKtXl/wWIMZYaIzz8MkR1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0oo6aB7b2RQxuN0ngq1CBJWk+kiQOYAk3B1A78GnSA=;
 b=ps2yyhdhTffcKMCkvIklYOMKiiwEZQqG4Zob0G/6HXdtxSmKju+zgT767Ns8fSHT9/DyMt1YOC7G8dUx8GUoylz2Yh74hi96u7Q8EoaP0NvoYejSfdUY2I8qOEFhGk3NcgwPL3ZMuGyug966K/uzCQcwz8o09H7UiJU11ZK7g9f4mwayQy0d8QbJTfXGNWTgwUrqUhgHUepRQjq6e9XqSfoL4uGPg/9Ap1bEx7Y8zerOoHNH+w0OmugHNp1sQ5iPVwhux0n8twUydgqn/AKAtbcOoE8qGod8z+vppVgXgWxDUIkMdg6VzRloJHkZstxnpOTuHhgAtVeJnP6DQmVevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0oo6aB7b2RQxuN0ngq1CBJWk+kiQOYAk3B1A78GnSA=;
 b=cjqW5JWWDapOFT6FrvIH2/Jvg9st3pYpWoUhv/7OSuphs7fpB92vdjOANdfRxaICDf0dhMKEwPsjx7LAO4aPekBK2X+3dfWDeIb9eegQxIpLMXj8RTVbKSxu+FFVQcfVKgPVHBZIgzmcAh4YZfhAgx7zaP5ntz4a8F/d3UR8nXQULVRSr5ZCqEpvktgexlmOQ0LgPm7NNsiGskgBxerO3avVtY7edLHXX43JfE5MTlA8UQoyY/9mTwOYNY14h45ClvRAOGaSNRLErRzmJBJXEtToSXrCEa/TtGLro+jFvsEpBNIAXWazAr2wMF2Jl+Z56crGoz11o2g/Rpi+yywrzw==
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 18:28:49 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 18:28:49 +0000
From: Gregory Etelson <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r1ijGnPC1ap0e+6CWAdV93u7OoNgYAgAEX6wCAAvBHrIAGyB+AgATktQCABK7JgA==
Date: Wed, 30 Apr 2025 18:28:49 +0000
Message-ID: <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
In-Reply-To: <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6330:EE_|IA0PR12MB8976:EE_
x-ms-office365-filtering-correlation-id: e16fa412-119b-4d15-7750-08dd8814da3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|13003099007|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WG2T3GUDMeAmnqVa1mOqgDl/z/BmPhe3AOxMhg84FrL7uCkOxfwwrEbngP?=
 =?iso-8859-1?Q?7tDvfZ0xXxzw+aGS4AV2kAZa/sX6cSEUz8nmJNZQp9HcXSN4V0gnhj02jo?=
 =?iso-8859-1?Q?JQUp9k/k/eP8p7KMv6im6bm3JIGXoCO0uXL3N+nmoKdw4RnF8f81HKXU6I?=
 =?iso-8859-1?Q?T+jCWKG6uMur9sFikF1Wj90skvNU6O+ZNTnGPmGEUHxeoVnaF41lZN+5Bz?=
 =?iso-8859-1?Q?iVKrOS9S1QvfremVkRtLYSQKSKB8koM109Bj/mkEO7CJk99vcUO8vY6psv?=
 =?iso-8859-1?Q?p93VK+q5FSOepC3HfU0IIyDYtndpr6Y4p3a5m+SPk4Xk1jcwrI6Z8s1Mvw?=
 =?iso-8859-1?Q?19sBDim8xwVp4lWeGpAr+mlpzAJk+Vb2oOenzCMhUJ5KOwcIqzEN37sqc2?=
 =?iso-8859-1?Q?tPpvlsdCpoeQnsCMtFvWuuwWD5fkNqpRpjCRhNBW+Su/GPiwbP1FsiiAQG?=
 =?iso-8859-1?Q?wcf9H7S45xkFIcx/FTWbnFOtMkCrrUi/5cL9f5gTNkumUH9OHMIKszzvyj?=
 =?iso-8859-1?Q?RVQIIY2qkLEa6biOxW28tdtrrseKLU2oO2+ZLOKhBdo8rmOQojA1nIciWI?=
 =?iso-8859-1?Q?rcbCbX1MS5uDt40tGRuCB01mRm80t3WHSCxt+3f3XQY/8Ee/ub7lwxLYCk?=
 =?iso-8859-1?Q?vi88nvjkClaGiqnVJOSdkmY2iT/8iuF0bwJSqDTUSzQ8yI2mrJl7Dp/7eT?=
 =?iso-8859-1?Q?qciJGJxNdjB+xTberb3CF58shuX/Hn+VxJQcJZxpYlyeHqWxWn0simvb8A?=
 =?iso-8859-1?Q?52qRiX6RAhw02FB8FEv/duYKW7CPAal6TryLQtNQKPO3HfB5nKrkni6oq5?=
 =?iso-8859-1?Q?jGARFNRHNWUgiKwnJ3pJvjoBBy66BF6+WwvH1GMPNDWMMeHwFyln5ERsJM?=
 =?iso-8859-1?Q?PtSLAODTvWOHUxcVkLMRKt61IS49ZUfxg5axnxBCant6bvfMcGDS9XWL/r?=
 =?iso-8859-1?Q?RZOB7xg+yGExMXDEgTFIA2sh8PV/NDKvl81PMsaX6/YZizrryOfpwEBMdn?=
 =?iso-8859-1?Q?5yAsWOFmIhgzW+UNQyj4pdRzLqjFrrvYbvWgOgWY5VSraI8dd6zl79XfRx?=
 =?iso-8859-1?Q?wN7I1i+5jvvJTOI5I7TYA0ruYIRI2rWzQeMoWZfIL2PMdY69pVIBgyjP5r?=
 =?iso-8859-1?Q?fwWHmDs7VnlliGYu3ftivaHE2mAwMmZlSPZB2CCBbgQaxKOJPuKOfsEudi?=
 =?iso-8859-1?Q?0cXr5dB+V++9Yk/xLprs/GIJ1TpROn85hra9ha3n6ZY6AODeYLws5WRhLS?=
 =?iso-8859-1?Q?gdLgwgxwXsL/YOcmNFapm2tjSiZOXHjzDNjAY8HneWeeSqb3whXfxbvhau?=
 =?iso-8859-1?Q?ADzKh69NYVuRftFBu2JFQi4oKuC43j5jyjzUbG68X2HqdEB4Sz1iyac5IP?=
 =?iso-8859-1?Q?Q7J22OggXMppZHhFh4vs4QyI9jewLUHk7148fbjUSMqxWKIN10hTjDOHE/?=
 =?iso-8859-1?Q?VJYmou5HQrG3Dv4uKTc5WWf4Q6M5Cz2yIBaM+oUUHIiUWuHhrnuMOr86xB?=
 =?iso-8859-1?Q?gCgKrB5/pRAJksOXy4+DBqTkqfrmBTlPn38IApToge65pvaIx93GhNNRCh?=
 =?iso-8859-1?Q?lCXqpsI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LMKir7QlkjMeZ4zRLcM/hF04J2g9/PSsDZlBmg7UCxOYkXoOglOrHWP07E?=
 =?iso-8859-1?Q?N7Bf8cSKvD2QqZQix+N11QOy7bXssnzT5U8t/3y6aLMsnGb+1x4H11+hzZ?=
 =?iso-8859-1?Q?dlyz808TOevZGsED0gbxdUa0wH/Vc6RqzACYvhH8uhy+BnikNQVW9Ubqsx?=
 =?iso-8859-1?Q?SBOSn1tU5kAr9esJsPZUrJcvmXXbTtW8qK2UuX4fVAM+DwQj55/lEQ0O2X?=
 =?iso-8859-1?Q?S0lbONa9vxn6m2QO8Stk8K1UUUAvUrsg87vf7Et5nMhDu0HdUP3Ww7c2tY?=
 =?iso-8859-1?Q?vkeJ6EWMDdKm3ne3NaOe1+E7BH9w+ekB4Rw+gAqJno4p9fNBRVFkqDNUzK?=
 =?iso-8859-1?Q?/WWrv7tyD9xIcG+ta1N0TVHe9y2is9U6ul9OCWi+duCB9xdGRwHW4D13zY?=
 =?iso-8859-1?Q?m8DCXymfaM9SvhYvFhrFk06cbdDtOvwDvQkAxVRjS5fOvRtYkf4BXIBtus?=
 =?iso-8859-1?Q?RFPR/fUt2Wly4c6+C0ISBomwSN8VW1MU+296LhbYi1MeG0od1GFcJ1ckjj?=
 =?iso-8859-1?Q?dUlpl699tYkETx6iSnwYMjr+L5PfvvPljVrfSRPIYY6UGjtK98OFx59m3q?=
 =?iso-8859-1?Q?wG1vzyiRJd2JbRdIwil4eSc+fP+jybqvxyTqPqFaPTWn5IJo0KDKGYwu9u?=
 =?iso-8859-1?Q?uiB21vl53q0hnzPnqknGmk2EgzFHRWZ5G578y/DKw49VnDSVROOh4iSGJC?=
 =?iso-8859-1?Q?ADua/o67KnpaaUfQ4fbIFewqpnwkyr3HbAUhrZtleHgeKMM55UGOlLYwJ1?=
 =?iso-8859-1?Q?EwVk9Gzj5+4XaopGjpAobI1ymkfRGxXTh713q7egCHzE5qVmF5AOSr3EVQ?=
 =?iso-8859-1?Q?W/kOzhrlwkJkDVLrpaVYz79VUq5BSjJM3bwZYMEyxqBYWRiXJ+j6YExqdC?=
 =?iso-8859-1?Q?ku3ceU7SftdiAPIPsMIjufwgfGJ7X6iFfUcl4Ek/8j0XDOaOemd0ZaGB9V?=
 =?iso-8859-1?Q?BNYRR4tkn1liMQuytfuxxoVTf75BsPG9zFqnqxLJsPyjI+WIotXOTok03h?=
 =?iso-8859-1?Q?UJK1Xus7YOcERLIbZdlTTeTA3e9Q2F11oY13jEUmUSR+Fx7ioiK7jFFev6?=
 =?iso-8859-1?Q?mcDTk1dTedpRiV3fUhxd7ip3026ixgpp8ztQMhanw7EuFHYwcKHY5fXbgz?=
 =?iso-8859-1?Q?Ds6TGrv6PNMnFxuv2mNw4hwcIfn0MABgqmRnc5FZlmBDK3iAmlGm8KZJzR?=
 =?iso-8859-1?Q?HW0UHKtDSw4qGQCf7qV1+pDgExFK4cue7JGmvL9blU/9YnU62/7n6n4U64?=
 =?iso-8859-1?Q?ZtzVpYyoO8pyr9cBovtDYV8xbAMyHlJJw3Z0vie56feu/QsVebhtoW6kVr?=
 =?iso-8859-1?Q?iunVJpBRN+7mbG965rZ0Vd1TEDxQ+44qm0BviZf4RQXdZ5/qfdRBC+li2s?=
 =?iso-8859-1?Q?5QxfSSWORIGtJ3J8NDTO7OiaJ02UzxLy57iHf/TStRJ84gc7vBt8TU3uAp?=
 =?iso-8859-1?Q?UR+90tGQsOAdL8EUft7cqXYSJ4RLJeASI/ICw0aGFlrWJg1s3Rtk4enQIj?=
 =?iso-8859-1?Q?enYo88Y3tkqtvsMAGhK7lSzdWu14z8NWLrt4QHVsx+XdqK4I35LK89tuW+?=
 =?iso-8859-1?Q?kdNundMl6aunpUo8x5gPjGC8FIdKoxHS5HFu+FVb7bqA5X9Haix41CEiqS?=
 =?iso-8859-1?Q?cLxP0GPeSRIWYtmWUnlzawo8OWUD9kfSyi?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB6330872DB96BB9D83EF7EFF2A5832IA1PR12MB6330namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16fa412-119b-4d15-7750-08dd8814da3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 18:28:49.8488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oBxo8RO5qxusVJRFho+6zmQnN//5uPIVSnJMO9xbe+pkVbgPQJk4SL83J8g/pseY4ZJz39cpNmsNtUZdVOtcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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

--_000_IA1PR12MB6330872DB96BB9D83EF7EFF2A5832IA1PR12MB6330namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Harry,

I've been experimenting with lcore workers.
Please check out the new helloworld example:  https://github.com/getelson-a=
t-mellanox/rdpdk/blob/safe-q/examples/helloworld.rs

There are 2 options for the example configuration:

1 Start RDPDK workers on the same cores as EAL:
    cargo run --example helloworld -- -a <PCI address> -l 0,1,3,5

2 Start RDPDK workers on dedicated cores:
    cargo run --example helloworld -- -a 0000:43:00.0 -l 0,1,3,5 -- -l 2-8

Regards,
Gregory

________________________________
From: Gregory Etelson <getelson@nvidia.com>
Sent: Sunday, April 27, 2025 21:50
To: Van Haaren, Harry <harry.van.haaren@intel.com>
Cc: Gregory Etelson <getelson@nvidia.com>; dev@dpdk.org <dev@dpdk.org>; Ric=
hardson, Bruce <bruce.richardson@intel.com>; owen.hilyard@unh.edu <owen.hil=
yard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq

Hello Harry,

> > I implemented a working echo server with your API.
> > The code is here: https://github.com/getelson-at-mellanox/rdpdk/tree/sa=
fe-q
>
> Ah cool! Great to see the API working.
>
> Reviewing the "echo.rs" code, the MbuffMempoolHandle ergonomics can perha=
ps be improved,
> I'll try work on that and have some API suggestions to the mailing list s=
oon.
>
> I see the echo.rs code uses a normal "std::thread::spawn" (not DPDK lcore=
s), there is
> some design to do here to ensuring that best practices are used;
> - any dataplane threads are registered as lcores (for best performance, m=
empool caches etc)
> - registered lcores are also unregistered when a thread ends (potentially=
 allowing lcore-id reuse??)
> I haven't thought about this much, but had a brief discussion with Bruce =
(who is on holidays now).
>
> Suggesting that mempools & lcores are the two next up API sets to "Rustif=
y" :)
>

I see 2 issues with the DPDK lcore API:

Unsafe "extern" lcore callback is not considered as new thread and compiler
will not run arguments Send verifications.

Also lcore arguments use generic 'void *' pointer.

Maybe Rust DPDK library needs native lcore implementation.

Differnet thread agrument types can we wrapped with a macro call.
Example is here:
https://github.com/getelson-at-mellanox/rdpdk/blob/37494bcae1fcf06bb4338519=
f931c2130105e576/examples/echo.rs#L88

Regards,
Gregory



--_000_IA1PR12MB6330872DB96BB9D83EF7EFF2A5832IA1PR12MB6330namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Harry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I've been experimenting with lcore workers.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Please check out the new helloworld example:&nbsp; <a href=3D"https://githu=
b.com/getelson-at-mellanox/rdpdk/blob/safe-q/examples/helloworld.rs" id=3D"=
OWA7a51a07b-97ea-b10c-f04a-a6e94f3d1b64" class=3D"OWAAutoLink">
https://github.com/getelson-at-mellanox/rdpdk/blob/safe-q/examples/hellowor=
ld.rs</a></div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
There are 2 options for the example configuration:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
1 Start RDPDK workers on the same cores as EAL:&nbsp;<br>
&nbsp; &nbsp; cargo run --example helloworld -- -a &lt;PCI address&gt; -l 0=
,1,3,5<br>
<br>
2 Start RDPDK workers on dedicated cores:<br>
&nbsp; &nbsp; cargo run --example helloworld -- -a 0000:43:00.0 -l 0,1,3,5 =
-- -l 2-8</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gregory</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Gregor=
y Etelson &lt;getelson@nvidia.com&gt;<br>
<b>Sent:</b>&nbsp;Sunday, April 27, 2025 21:50<br>
<b>To:</b>&nbsp;Van Haaren, Harry &lt;harry.van.haaren@intel.com&gt;<br>
<b>Cc:</b>&nbsp;Gregory Etelson &lt;getelson@nvidia.com&gt;; dev@dpdk.org &=
lt;dev@dpdk.org&gt;; Richardson, Bruce &lt;bruce.richardson@intel.com&gt;; =
owen.hilyard@unh.edu &lt;owen.hilyard@unh.edu&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, E=
th and Rxq</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Hello Harry,<br>
<br>
&gt; &gt; I implemented a working echo server with your API.<br>
&gt; &gt; The code is here: <a href=3D"https://github.com/getelson-at-mella=
nox/rdpdk/tree/safe-q" id=3D"OWA7afd59b3-9b37-32bc-9bc0-16ca5a27245c" class=
=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://github.com/getelson-at-mellanox/rdpdk/tree/safe-q</a><br>
&gt;<br>
&gt; Ah cool! Great to see the API working.<br>
&gt;<br>
&gt; Reviewing the &quot;echo.rs&quot; code, the MbuffMempoolHandle ergonom=
ics can perhaps be improved,<br>
&gt; I'll try work on that and have some API suggestions to the mailing lis=
t soon.<br>
&gt;<br>
&gt; I see the echo.rs code uses a normal &quot;std::thread::spawn&quot; (n=
ot DPDK lcores), there is<br>
&gt; some design to do here to ensuring that best practices are used;<br>
&gt; - any dataplane threads are registered as lcores (for best performance=
, mempool caches etc)<br>
&gt; - registered lcores are also unregistered when a thread ends (potentia=
lly allowing lcore-id reuse??)<br>
&gt; I haven't thought about this much, but had a brief discussion with Bru=
ce (who is on holidays now).<br>
&gt;<br>
&gt; Suggesting that mempools &amp; lcores are the two next up API sets to =
&quot;Rustify&quot; :)<br>
&gt;<br>
<br>
I see 2 issues with the DPDK lcore API:<br>
<br>
Unsafe &quot;extern&quot; lcore callback is not considered as new thread an=
d compiler<br>
will not run arguments Send verifications.<br>
<br>
Also lcore arguments use generic 'void *' pointer.<br>
<br>
Maybe Rust DPDK library needs native lcore implementation.<br>
<br>
Differnet thread agrument types can we wrapped with a macro call.<br>
Example is here:<br>
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/blob/37494bcae1fcf=
06bb4338519f931c2130105e576/examples/echo.rs#L88" id=3D"OWA7e93c2eb-d2f9-0d=
ea-b07b-d81f00fcbd6b" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">htt=
ps://github.com/getelson-at-mellanox/rdpdk/blob/37494bcae1fcf06bb4338519f93=
1c2130105e576/examples/echo.rs#L88</a><br>
<br>
Regards,<br>
Gregory<br>
<br>
</div>
&nbsp;
</body>
</html>

--_000_IA1PR12MB6330872DB96BB9D83EF7EFF2A5832IA1PR12MB6330namp_--
