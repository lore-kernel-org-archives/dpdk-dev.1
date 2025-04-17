Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC78C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 16:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D16400D6;
	Thu, 17 Apr 2025 18:19:29 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by mails.dpdk.org (Postfix) with ESMTP id BE1FE400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 18:19:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD6jQiJiPEOQhEVLDNAYYpJBG64iF3CChNs2gP8ryMZqHksVa5UHGXjrUndSstUEgJQ7r09WeXVO7Ia2+5oQkJM58qGkKEZ1mX2Bht3hYXC6FwUE0LGlLAUlDRFWnayDeuJeBZL7VGDCMD4kOXK5NpLDaPpwqclBkUwxwAg6GGCRA8j8/qQx578ZFmU20T11lfLaH/dZsod+h+ZuJhU8Mpo6pHzolZQddGC6OPV1yVrgeKK7tkp9rmXsM5B+StZMMP+JReIWsiUHBZUa6tryoUR2UkRhfGIUklGd9QcmujxguJLaPcqdAelKuMliq3EwqW5KusqmUO9SP9BX24qXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfS1cPx9WS4COnInmvC/rj5IfsiuUhX1J4sZmK1j3Hs=;
 b=sIDQ7+M7uJ0ljDwGCecsVHmUIomoF9iY6HXRRDl6tn0+Zn/5lfyvGSx3SiaoVDgIRwazv2MOi7ivttfxhE8U47neeGEjFbsC27bjVQubqeIwGTEcdmjtf7Di4WQx2837EpgZ4ODXf28nKWfQncc7UqV8s2Yx8TElFe1c7T5MBmwLHhv/AZrdkSEmzWGjmvR3qKbuNJGmRQFqGP/ZWt7N16nQEEZe8ODO81yrI1SQGTmbskCS18rzv0Dnm3YVNor7jxLaRSUXoVCQGM2jLmT1Q2PckBY6nSWkOhyww3oqO/LachJJKc/OuOui8bvGIFfG/8j9LBzF9uVePglQqzFELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfS1cPx9WS4COnInmvC/rj5IfsiuUhX1J4sZmK1j3Hs=;
 b=Ggg5OyPbVzkNn7+J+8idzXevBbJUKgwLClCwBUJQ6djoKL0pCwsIJvWxynSVYxXXgAS+1sBqJPMNdTuN5MO4C16Jofz8BCKs7w7110PVE0qSDGD5Xe+zDcE+KjO1hsyeziISKsP0SqvYPGUUvdsoTgYNcuN/petGSRC76SY884fbaaUPLBO3fJW8QE6ZZjkg7TK84rBoUwBRX10/5j56Xo7tqwiOi7ENKAyG471GxpoTe9p4WQpWSu7XVUNcu9uAknEtdaXrFztNV+wZJx+hPMKMCY8Rx7nZA9OoPOeKuDL3AJLK4bwd9JlWbUslyd4G9J2cHqplht2tHROx1BQs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 16:19:24 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 16:19:24 +0000
Date: Thu, 17 Apr 2025 19:19:21 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] add Rust API for basic port operations
In-Reply-To: <PH8PR11MB680361C556B7E2164363C5E3D7BC2@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <6de4c566-080a-4d9f-733a-7604d30c53a0@nvidia.com>
References: <IA1PR12MB633009C4430CF2081D824D3AA5BD2@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680361C556B7E2164363C5E3D7BC2@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 06eec819-0614-41b7-f09c-08dd7dcb9e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHdNjl6j4f0gqhMX52zsrUcHO5LVuDw+nnrAwqbEfMO4HSp2y7K/FyZ876mc?=
 =?us-ascii?Q?brfmrmPZx730opI0cWm9bskpOLoYLk4iqGaFIKQLjMNPCO4utM18vyQFrME7?=
 =?us-ascii?Q?ePGfOP3XAVkc/RKatQtFu7+/wnVJFlnXK+UOHMoKZt8T+Pfjdj7MluakFuvZ?=
 =?us-ascii?Q?E/cmI9MLNWEl5B4ocrPN7eQovG40I25Z4fC309QGdJjvaeH8j4qNE5x4aeDK?=
 =?us-ascii?Q?tiNVoskYZAt+yar9CP3X4GvW7Qoz1DBj2ukwsqysMhiAQgE/GdMXcs8Yj00S?=
 =?us-ascii?Q?23m4erCsHWcOEYOO/oSb4fX44XLLKOHF3FTpzSZaBjBHIrEJDKYlhq+cBIuO?=
 =?us-ascii?Q?OYwadHCu7EDG1nmzr0yo2dMXU05pgGIM7IhLLQV2u44ruRBeZrGFlGFP+0u7?=
 =?us-ascii?Q?xVgEgjXXUgZzwod6EjAHzlcBJRetzA+Pwp5BSrvz/iZGdEGAxtkNRo9Vr/AB?=
 =?us-ascii?Q?wvf8vlb9DZeqgqqS4DcmuerflWqEojuFgRPcpzUEoqOWy/6LSv7X+LzN3kqv?=
 =?us-ascii?Q?VK6OKNJnq1SNP/3XRPTNWKFiOZwXSwfd4YOxDSrR8mEE7jzuu2X7ObKy8v4/?=
 =?us-ascii?Q?8EBpB1GquH1bSOnsoJ64COlO9KEUV4edUC+pzNaOCNskq2QUOzohtzRwgDqt?=
 =?us-ascii?Q?Wsevv89DbUscw/1BWnUmoqGOcoYut2Mz+1QMNHFyO1Qzka2RZm4KEv2xDQVQ?=
 =?us-ascii?Q?o81MGdLEW2v0zZ2q/LPPfzgQfpk5Jz717FUs2HVkqW3KsxlP4mWaTiU13GoN?=
 =?us-ascii?Q?HRPKsm+yc0I5qe1/50yF5Zv+vdOObClIE+IJk0y6uN3ARkTdhIi0uhoh63JN?=
 =?us-ascii?Q?2Mh7SNQAJLY2fszqms7WME7vcgSeQ8dsxItnE6PVnV8He9y3HdCehUGfWmK0?=
 =?us-ascii?Q?YrbPQzPaYtjLS5Dl5hqY47Zvx1/2HxIAs61N/GqxFiOOlkJ7hErqv4PM0O7X?=
 =?us-ascii?Q?ZVcNRHYyoNcWettZWus8C1kOecMNVeHjZl+Cl4Z8GMwCwwfz+NSoPJQsZoWT?=
 =?us-ascii?Q?r/oacRAhcvWvu0Iws21bqmgNeiimr3/SGshcAZYewOirt/lWcwkgbUOJxnTT?=
 =?us-ascii?Q?1gNvNj6Aa38nxwOlQTt5fchVWSByP0yxAekJv55oAXwRe+3le74jNnS4IksV?=
 =?us-ascii?Q?lPiBHPdJZUlsOIDGVZgN24EYmSuFELqGnSF58lIHLMZJVRYi2Za9+ZQ+czHH?=
 =?us-ascii?Q?+o8PX1uchIiS26vpllOgztnvS9gotTL8NrFJP8CFRthX413DJPFwOS5frvYk?=
 =?us-ascii?Q?Mnb5PFDiTJelbuQbY2HoBVIJTae6VqJVR96bg3cWpfeiyle6r3WjmVpZRliw?=
 =?us-ascii?Q?YzA5ry0f0GoB6AI79VvZWTCMeidd6zlGpJvsF2nYtQmSX9EhVcKSSi2zhKFO?=
 =?us-ascii?Q?44UGNxHS9ehRcYm40TFINrtwexvHLEbHZKxFZ65s3+IiEQx6Hg7cD9p12Cfx?=
 =?us-ascii?Q?2p20hH8AtZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqqg8GstgG60VSv3wVA+MvuFh+E+EzdIVb0OLlrNutcPFckqOgxNBTtdIYYG?=
 =?us-ascii?Q?3Ufxx9KMQefs/zpG5c5abWdPIZp8MmKEHFdIHYY/3jUQrShmjIRTXwMnPHVe?=
 =?us-ascii?Q?udl+ZJKfczgh/vSbicOIzQFFGMasxKSwsr42HGS0wL2oWCAqLpH3iT3F2Ubj?=
 =?us-ascii?Q?BgTOtVpJufEo5FGamVYXQse9I3SEuTachCD2HUmvLIHlDTppmD+ODz+4XJ9L?=
 =?us-ascii?Q?w9cgsTTx7ZnTmVWZuk+B3Wl/Tc0ScIHEATr8C/IYBwKtglN7pqxLHr6N0+2c?=
 =?us-ascii?Q?orn52Afh4E1u6uCgJkINBUqtp79Rd77YWLsjBZ735BtRExHrLAMl6bWy9Ese?=
 =?us-ascii?Q?HDklKH9TgW4CEMjNropqKisJznSkSvPNxBLVzrplU4HXFVaT++TycNr110pP?=
 =?us-ascii?Q?qakldWfv8xSz8pOQqZx4SdOj/B4Na5QHTYrm40AXhBRf5szdHucJK541Etc1?=
 =?us-ascii?Q?n53oIwCol02b+79oFXUe1d2m/BGbQG0uMF/eihdbE/arMK9fkt85vsw+HChg?=
 =?us-ascii?Q?XBC5vChmBraK6bFnKsXy0Cpc1Pyvv1zpVzTOR+d4iQADWJpJWSiqOk3o5fE4?=
 =?us-ascii?Q?IHr6MONCWGcUF/HjC+fjYDcM1Bid8/i5joyUXNCAK+GEZ6eMZHbEOe1u1Je9?=
 =?us-ascii?Q?gqW1UKySftEtJ1VSQXB/5s2pKO7+pVTwilymq4AWJlW/7GvjSZ4Z9bAf0JRj?=
 =?us-ascii?Q?lMBKCsvKketDqXlnmmEIK+/FdO/WKxMyyYIot0CoaHra/+mm+oMEuCmhovfh?=
 =?us-ascii?Q?4hCHVsIvf0o4qpzHyPm0KzjBfSc/9gAdk7gVN+RlNPPetzMYrS9hO071JeJj?=
 =?us-ascii?Q?QvQ7waXdSshXKWSB9QminYd04TcgGucfBaHntNenLgU/brPnrPDwU55nD5YJ?=
 =?us-ascii?Q?9Z+KOgFYMFv6U54/+N7hB+ShhwgsGhw/fB/lKDccQNI1zqZMRM2B3oHzoPKz?=
 =?us-ascii?Q?FT/jOYIeX20c+1ggSFhDpKAwtaFQwc0D9CSm5Lv7GOAykQtwG2eJdonjRoW/?=
 =?us-ascii?Q?rTMmBOSFG/vGC4vFb51iVXUhMQQ+T6jr6Ug0MHBg4iBcmpbWbdVX/3k2lk0D?=
 =?us-ascii?Q?OgZZ9KPIuSSj/g57mcd3bj7KuugbBX71SufRa3surQdWQwqVJk/gQ8KxROKb?=
 =?us-ascii?Q?+7XfkK2wVN1TKTwwDjJQrBo603oBbPg80Ae8uDqQGPfEBL9Kz4XA6Cm6A8ye?=
 =?us-ascii?Q?DAOVETzhYNX1hh5vZYLeOTpBvoO5Gpus8qRgBspPRchT5nJBYlDv+8iUg8X4?=
 =?us-ascii?Q?i/MoxbymkM9RvXJEK4FcAK2+H5tWtg8LN+V2fSfec+JIbhVizdwV9mLgEUQs?=
 =?us-ascii?Q?z3+ZY3JFEPjwHJyv4rAoqo30SiZMG9LEL+VBnFy2UDRRGeq5fsMx3j52Adq8?=
 =?us-ascii?Q?70L1+KaxPWdJQLtWZxXYFpAbQ/hCHA9/EBWOuvoDZ3jbcsihTQbCrJ02Uw5G?=
 =?us-ascii?Q?3ZnfSthr+QxQWNcPsvTrVnnAHiOTjtHlH23n8lk1FFUzjcb89q+IaD+7co2E?=
 =?us-ascii?Q?AfUAY38Il0ae1Ls3XPeDLHUt0NlPgTvKerhvnZdphqRPVIG3DEJnO6wD0Oec?=
 =?us-ascii?Q?8YQ8SdxGC7U6mW9VeZ7dQAxMgwKXBjeDPpkoygIg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eec819-0614-41b7-f09c-08dd7dcb9e13
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:19:24.3295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTXX0gl0lyAEtz+cDlp6Qp2nuPxfq1RBVz+0g/LtqeWwKKBlmknFChPwOj124xMWDzwokzvB2LP1YlhkwR5l+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

Hello Harry,

>
> Thanks for posting this RFC. I'll share my API RFC in the coming days too, for now
> some feedback (which is already integrated/existing in the API I've been working on)
>
> Bigger picture; the APIs below implement "DPDK C API thinking" in Rust. I'd like to rework the APIs to be "DPDK with Rust Ergonomics" instead:
>
> Example:
> 1) DpdkPortConf::new_from(0, c_dev_conf_struct, c_rx_conf_struct, c_tx_conf_struct, 8, 8, 512, 512, mempool (or None));
>    - the API here is not use case focussed. The values passed in are documented, but not easy to explore/understand.
>
> 2) let ports = dpdk::get_ports(); // returns a Vec<DpdkPort>
>   let p = ports.get(0);
>   p.rxqs(8, rx_mempool)?;
>   p.rx_crc_strip(true);
>   p.set_rss_hash(&[0,1,2,3..N])?;
>
>   // Notes: configure RX values: note the type-safe, and english-syntax functions.
>   // These functions prompt in modern IDEs, making "exploring" APIs easy/fast/intuitive (struct member bit-fields are not as easy to explore)
>   // The "rxqs()" function takes the parameters it needs (u16 count, and a Arc<Dpdk::mempool> object)
>   //   - this avoids exposing an "Option<Arc<Mempool>>" publically, hiding impl detail, giving better ergonomics
>   // Notice the "?" operator, this can be used "inline" to early-return and error (e.g. rss_hash array has incorrect length)
>

Agree.
That approach is much better.

>
> The ability to error check individual functions/APIs allow better error reporting to the user,
> specifically at the point where the error occurred. As these are not datapath APIs, allocations and
> overhead in the failure case should not be a problem - user-experience is the goal:
>
> 1) on error: -EINVAL returned from rte_eth_rxq_configure(), difficult to see what parameter caused the -EINVAL.
> 2) on error: "rss_hash has invalid lenght of 42" (or whatever we make the Debug/std::error::Error impl say)
>
> To summarize, "use-case focused APIs" are easier to read, debug, and maintain.
> The work here is to design/build these Rust ergonomic APIs: it takes DPDK knowledge, and some Rust API
> best-practices to figure these out. There's probably a "playbook" of like 3 rules/strategies, which will
> cover 90%+ of the API design.
>
> Hopefully this email is a starting point; some resources for future reader's reference;
> - https://burntsushi.net/rust-error-handling/
> - https://corrode.dev/blog/idiomatic-rust-resources/ (look for "error-handling" tag)
>

I'll definitely check these out

>
>> ```rust
>> /// Configuration details for a DPDK port.
>> ///
>> /// # Overview
>> ///
>> /// `DpdkPortConf` is used to initialize and configure ports in a DPDK environment. It includes:
>> /// - Device information (`dev_info`) pulled from DPDK.
>> /// - Transmit and receive configurations, including queue settings and memory pools.
>> /// - Details about the number of queues and descriptors for transmission and reception.
>> ///
>> /// This struct is typically instantiated using the [`DpdkPortConf::new_from`] method.
>> ///
>> /// # Example
>> ///
>> /// ```
>> /// let conf = DpdkPortConf::new_from(
>> ///     port_id,
>> ///     dev_conf,
>> ///     tx_conf,
>> ///     rx_conf,
>> ///     8,               // Number of RX queues
>> ///     8,               // Number of TX queues
>> ///     512,             // RX descriptors
>> ///     512,             // TX descriptors
>> ///     0,               // RX queue socket ID
>> ///     0,               // TX queue socket ID
>> ///     Some(rx_mempool) // RX queue mempool
>> /// ).unwrap();
>
> A few observations; The DpdkPortConf itself is a Rust struct, but internally it exposes a number
> of "pub" fields (rte_eth_dev_info, _eth_conf, rte_eth_rxconf, ...), which are directly bindgen-ed
> from the DPDK C API. While this works, it will not provide the ergonomics we'd like for Rust code.
>
> For example, the eth_dev_info->driver_name is a CString (aka, const char *), which needs to be
> converted to a safe Rust CString or CStr (see https://doc.rust-lang.org/beta/std/ffi/struct.CStr.html#method.from_ptr)
>
> A big value add in Rust development is the automatic "Debug" implementations, allowing one to just
>        println!("{dev_info:?}");
> a struct, and that the compiler is able to identify the contents, and present them automatically.
> That will not work if we have C structures with pointers, resulting in bad debug/logging for users.
>

What about explicitly implementing Debug for types that are referenced as pointers ?
For example:

```rust
#[derive(Copy, Clone)]
struct MbufPtr(*const rte_mbuf);

impl std::fmt::Debug for MbufPtr {
     fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
         if self.0.is_null() {
             return write!(f, "MbufPtr(null)");
         }

         let mbuf = unsafe { &*self.0 };
         let data_off = unsafe { mbuf.__bindgen_anon_1.__bindgen_anon_1.data_off };
         let pkt_len = unsafe { mbuf.__bindgen_anon_2.__bindgen_anon_1.pkt_len };

         write!(f, "MbufPtr {{ address: {:p}, data_offset: {}, packet_length: {} }}",
             self.0,
             data_off,
             pkt_len
         )
     }
}
```

The activation is like this:
```rust
let mbuf_ptr: *const rte_mbuf = PTR;
println!("{:?}", MbufPtr(mbuf_ptr));
```

Output:
```
MbufPtr { address: 0x1033af140, data_offset: 128, packet_length: 62 }
```

>
>> ///
>> #[derive(Clone)]
>> pub struct DpdkPortConf {
>>     /// Information about the DPDK Ethernet device (e.g., driver, capabilities, etc.).
>>     pub dev_info: rte_eth_dev_info,
>>
>>     /// Configuration for the Ethernet device. Determines the overall behavior of the device.
>>     pub dev_conf: rte_eth_conf,
>>
>>     /// Configuration for transmitting (Tx) packets on the Ethernet device.
>>     pub tx_conf: rte_eth_txconf,
>>
>>     /// Configuration for receiving (Rx) packets on the Ethernet device.
>>     pub rx_conf: rte_eth_rxconf,
>>
>>     /// Number of receive (Rx) queues configured on this port.
>>     pub rxq_num: u16,
>>
>>     /// Number of transmit (Tx) queues configured on this port.
>>     pub txq_num: u16,
>>
>>     /// Number of descriptors for each transmit (Tx) queue.
>>     /// Descriptors represent items in a queue to handle packets.
>>     pub tx_desc_num: u16,
>>
>>     /// Number of descriptors for each receive (Rx) queue.
>>     pub rx_desc_num: u16,
>>
>>     /// NUMA socket ID associated with the memory used by receive (Rx) queues.
>>     pub rxq_socket_id: u32,
>>
>>     /// NUMA socket ID associated with the memory used by transmit (Tx) queues.
>>     pub txq_socket_id: u32,
>>
>>     /// Memory pool associated with receive (Rx) queues.
>>     /// This manages the buffers used for storing incoming packets.
>>     pub rxq_mempool: Option<Arc<DpdkMempool>>,
>> }
>
> Any reaons that rxq_mempool has an Option<>..? Is it for TX-only port configurations?
> That's the only thing I could imagine is a cause. See above API where RX and TX are
> configured independently - this avoids passing an "RX mempool" at all, if only TX is configured!
>

Right. The Option<> is for Tx only configuration.

>
>> /// A trait defining basic operations for managing and interacting with a DPDK port.
>> ///
>> /// # Overview
>> ///
>> /// The `DpdkPort` trait standardizes how to operate on DPDK ports, making it possible to:
>> /// - Configure the Ethernet device using [`configure`].
>> /// - Start the device using [`start`].
>> /// - Handle Rx and Tx bursts of packets using [`rx_burst`] and [`tx_burst`].
>> ///
>> pub trait DpdkPort: Send + Sync {
>
> This trait provides a very C API centric view. Unfortunately, that view does not include the
> Rust API semantics we need for RXQ and TXQ being Send/!Sync (see https://youtu.be/lb6xn2xQ-NQ?t=802)
>
> Example of INCORRECT usage of this RFC API (that Rust compiler cannot help with)
> (refer to https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx5/mlx5_port.rs#L30 for port creation)
> thread 1:
>   let port = Mlx5::from(0, &port_conf);
>   let pkts = &mut [*mut rte_mbuf; 32];
>   port.rx_burst(0, &mut pkts); // segfault simulateous access on (port/queue combo)
>
> thread 2:
>   let port = Mlx5::from(0, &port_conf);
>   let pkts = &mut [*mut rte_mbuf; 32];
>   port.rx_burst(0, &mut pkts); // segfault simulateous access on (port/queue combo)
>
> The problem here is that the user was able to create two "handles" to the same "port".
> And from that handle of a port, it was possible to call rx_burst(), (or tx_burst(), etc).
>
> The Rust compiler cannot identify that Mlx5::from(0) is not safe to call twice.
> My current preferred solution is to have a Dpdk::eth::get_ports() API, which returns
> all the port instances. This removes the user's ability to "create" ports at all, and hence
> it cannot be mis-used either.
>
> All in all, the method in which C DPDK APIs work (pass in integer ID for port/queue), is
> a very different to how safe Rust APIs will look when building in Send/Sync safety.
>
>

I see your point now.

>
>>     /// Returns the port ID of the DPDK port.
>>     ///
>>     /// # Return Value
>>     /// A `u16` that uniquely identifies the DPDK port.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let port_id = dpdk_port.port_id();
>>     /// println!("DPDK port ID: {}", port_id);
>>     /// ```
>>     fn port_id(&self) -> u16;
>>
>>     /// Returns a reference to the configuration object of the DPDK port.
>>     ///
>>     /// # Return Value
>>     /// A reference to [`DpdkPortConf`], which contains various settings like Rx/Tx queue configurations,
>>     /// memory pools, and NUMA socket IDs.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let port_config = dpdk_port.port_conf();
>>     /// println!("Rx queues: {}", port_config.rxq_num);
>>     /// ```
>>     fn port_conf(&self) -> &DpdkPortConf;
>>
>>     /// Configures the DPDK Ethernet device with the settings specified in the port configuration.
>>     ///
>>     /// This method is typically called before starting the port to ensure it is prepared for Rx and Tx operations.
>>     ///
>>     /// # Return Value
>>     /// - `Ok(())` if the configuration was applied successfully.
>>     /// - `Err(String)` with a descriptive error message if the configuration failed.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let result = dpdk_port.configure();
>>     /// if let Err(err) = result {
>>     ///     eprintln!("Failed to configure the port: {}", err);
>>     /// }
>>     /// ```
>>     fn configure(&mut self) -> Result<(), String>;
>>
>>     /// Starts the DPDK Ethernet device.
>>     ///
>>     /// This method initializes the Rx and Tx queues, making the port ready for data transmission
>>     /// and reception.
>>     ///
>>     /// # Return Value
>>     /// - `Ok(())` if the port was started successfully.
>>     /// - `Err(String)` if the startup process failed, with a descriptive error message.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let result = dpdk_port.start();
>>     /// if let Err(err) = result {
>>     ///     eprintln!("Failed to start the port: {}", err);
>>     /// }
>>     /// ```
>>     fn start(&mut self) -> Result<(), String>;
>>
>>     /// Receives a burst of packets on the specified Rx queue.
>>     ///
>>     /// # Parameters
>>     /// - `queue_id`: The ID of the Rx queue to receive packets from.
>>     /// - `pkts`: A mutable reference to an array of packet buffers (`*mut rte_mbuf`) where received packets
>>     ///   will be written.
>>     ///
>>     /// # Return Value
>>     /// - `Ok(u16)` containing the number of packets successfully received.
>>     /// - `Err(String)` if the operation failed.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let pkts: Vec<*mut rte_mbuf> = vec![std::ptr::null_mut(); 32];
>>     /// let received = dpdk_port.rx_burst(0, &pkts);
>>     /// match received {
>>     ///     Ok(count) => println!("Received {} packets", count),
>>     ///     Err(err) => eprintln!("Rx burst failed: {}", err),
>>     /// }
>>     /// ```
>>     fn rx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Result<u16, String>;
>>
>>     /// Sends a burst of packets on the specified Tx queue.
>>     ///
>>     /// # Parameters
>>     /// - `queue_id`: The ID of the Tx queue to send packets on.
>>     /// - `pkts`: A reference to an array of packet buffers (`*mut rte_mbuf`) to send.
>>     ///
>>     /// # Return Value
>>     /// - `Ok(u16)` containing the number of packets successfully sent.
>>     /// - `Err(String)` if the operation failed.
>>     ///
>>     /// # Example
>>     /// ```
>>     /// let pkts: Vec<*mut rte_mbuf> = vec![some_packet_ptr1, some_packet_ptr2];
>>     /// let sent = dpdk_port.tx_burst(0, &pkts);
>>     /// match sent {
>>     ///     Ok(count) => println!("Sent {} packets", count),
>>     ///     Err(err) => eprintln!("Tx burst failed: {}", err),
>>     /// }
>>     /// ```
>>     fn tx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Result<u16, String>;
>> }
>> ```
>
> Having a single trait with configure(), start() and rx_burst() makes it impossible to encode the
> Send/Sync attributes of the "Port" concept, and the "RxQueue" concept seperately.
> So perhaps a solution with two traits could work; I haven't investigated in detail yet.
>
>
>> The API uses raw FFI pointers in DpdkPort rx_burst() and tx_burst() to preserve DPDK performance.
>
> Cool, nice trick... but does it remove all virtual functions/function-pointer dispatch?
> - https://github.com/getelson-at-mellanox/rdpdk/blob/main/app/runpmd/runpmd.rs#L143
> This seems to accept a "&mut Vec<Box<dyn DpdkPort>>", which would mean the ".rx_burst()"
> is a virtual-function into the trait, and then a function-pointer into the PMD?
>

Mlx5 trait implementation calls PMD rx_burst() and tx_burst() functions directly.
This way I did not need to re-implement original DPDK static inlining for IO calls.
For that approach to work DPDK must be patched to expose PMD IO functions.
See 
https://github.com/getelson-at-mellanox/rdpdk/blob/main/dpdk-patches/0002-net-mlx5-refactor-Rx-Tx-functions-selection.patch


> It could be interesting to change "do_io" to a generic function, taking a generic DpdkPort instance? Then the first level
> trait-resolution would become compile-time (through Rust compiler monomorphisation of the generic do_io<Pmd: impl DpdkPort>() into a
> more specific  "do_io<Mlx5>()"  code?

For multi-hw setups that function declaration need to be `do_io<R: DpdkPort, T: DpkdPort>()`
But that will not compile for Rx-only calls.
Without generics the function works for any HW type and for all directions.

>
> I don't believe this to *actually* matter for performance. It might matter for an IO-forward, 0 packet data processing test.
> So micro-benchmark bragging, yes this has impact... but touch the packet data and it no longer matters!
>
>
>> The API implementation is here:
>>
>> API definition:
>> https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/port.rs
>>
>> API implementation with RTE function calls:
>> https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/raw_port.rs
>>
>> Implement direct calls to mlx5 Rx/Tx IO functions:
>> https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx5/mlx5_port.rs
>>
>>
>> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
>
> Thanks for sharing the links and RFC!
>
> I will share the RFC API that communicates the Send/Sync requirements to the Rust compiler for Ethdev Port Rxq as a sample,
> and we can try compare/converge the "trait DpdkPort" and the compile-time-thread-safe approaches into the best API?
>

== thumbs-up ==

Regards,
Gregory
