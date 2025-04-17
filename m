Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C77C369CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 18:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 786FE400D6;
	Thu, 17 Apr 2025 20:58:29 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by mails.dpdk.org (Postfix) with ESMTP id B19BA400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 20:58:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THO1kE6glQ2XN7rRLtR+j8LYsZI31xpcxqAh60BlpaBMfh0vixrvVwe1xSLlO3KKyLG//lJAogtyRr46THRCXcq76npOgje5bE+VztlFGTV1WASVXPFHHmBxHlUm1OHJzswImO8KCFLZuIC++P6MIYx5IwGCKYDsa/yL7SUj5Dci26X9IHrgdPN7KhYu9am7+tjWvOmDyiFE6G7bWxbb8bA7m2TbPsx4pwlMJbq5c6hUMapYkJAXg3PKXxl4RjXQeGeJGcJWRxB4OSmj7d8jS2tf0xCFLyMHkQ0wFsfx7eCW7gSoj2ef12BeN6PIBe3jYiyA/40xx55ya5iVoDzPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2zQudFIKbCsmykXe2rT25QhV8ma9fEBor/TCrD1Xww=;
 b=Vy6kTMNevZ39P5vDlWBFvXFiHfJ4V2WlW9IUAlinWuKRv/BDTospeQMR3Ua8XpAFq4Brtz0V9uyMh44HsVEB4gUTMLGSTZjv4lu1ZjlE2UDksKmKWSvN8BkufORO/V4OQfjdU77mXvFml0Gm7CjLHNdmKBo/uK/QNdTNmDBChLfN1hmvdq/Ti/sPGl+y/ZGA/OdiFFzO6caFcv5TfpxT4oddhHv0ZfCXl9MRgbxV44TMFU1xGxUxiDhExLyi/l699FwMcTIobyrCL5rJ2iOotPPccav3SrIeRZ9GxuKMVQTGDgT23WCJUTPnEljAlEjgn4rOVj6g4d5O3hKLqCEZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2zQudFIKbCsmykXe2rT25QhV8ma9fEBor/TCrD1Xww=;
 b=SF8LXeEhyF8e0IVAMHi8t/kt9du6rm7A/MzLcXfexHYx2t2UFeeYQ7ciNQMOioH1ySYx5NxJ3V5u3CABPDDYHuItb5EMlcUNLhvGlHIpH0/xDqH+dZwIA2fhZUZjUgpv89ScRyJaZqUjUspQi6omfiHLvd6+R5nG8+0Y7rDiLCWsM5Fv7G5tzUbSMqfHddid+dT2KK9DnySrk5vY/4QWo6N5xpONO98I7e47hxuSwJGY3dRKznCHFFec2AffB5cDAsvxaRpXfh6gm3uShsTPOI+kPS9i+0HnPW6Zit8el5SCs5WiXfleSNDDC14OhSl7CR5fHAiVhY72YlOjwBUkjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 18:58:22 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 18:58:22 +0000
Date: Thu, 17 Apr 2025 21:58:18 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Harry van Haaren <harry.van.haaren@intel.com>
cc: dev@dpdk.org, getelson@nvidia.com, bruce.richardson@intel.com, 
 owen.hilyard@unh.edu
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
In-Reply-To: <20250417151039.186448-1-harry.van.haaren@intel.com>
Message-ID: <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d117338-d92b-4e28-c8b5-08dd7de1d35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FTYEqa48jyvs7GyEEPK7lg6Xxeyl4ts2YfGoEF38Y035RqJjSk9+4WYkaGmV?=
 =?us-ascii?Q?YiKC2CBICRWeAUr76pL2ejHxp/mIrmhmKwuLbrNui2OWiJpf1h/SG+PK81BA?=
 =?us-ascii?Q?HmhnG07qYdcrAK6wuz55X/6OKFhq9IlghwPH2i6sTZtnUTV8SE2ek6lukGaz?=
 =?us-ascii?Q?pqWJa2/cDKpE9teDMToquI9S3U7D4+M6VDkC4asbjSBw/NsqiQoZdF5AiQJb?=
 =?us-ascii?Q?9ETvNNca830OiZuCX67+TO9MIqdAfMPqYt4r3PLqSEoNc3/8WwfLdv1fxO7D?=
 =?us-ascii?Q?bhHjFJB7DSHIGnHHX9XbzT6ReOBLxgubssxcRMtf01wTwG3s+SYFJCSTlpH0?=
 =?us-ascii?Q?fzmApLowvnT9dn4LxenW8qRp3Y0R1gqZyTTPgS3hTabAOXit6rTYWzeoz75c?=
 =?us-ascii?Q?6odkFQqQ05fhVaDcwQe9zS7+4BZNjTCbDnAxtoeKhNGbnosvuQyOH9hLo8Y1?=
 =?us-ascii?Q?oa+xxeO+77UnOH+kYj1sYSWYdRh+bttf81QiOKayVUMR4OvzYiVsAxKOrOIK?=
 =?us-ascii?Q?vcH7LDuJ42TQ+fkR7Yg9H79mmyToDiRdr724COwdhqyaVzWH+/8sYP+ShntX?=
 =?us-ascii?Q?xeK8g1SZkVCfGagEoUpDHp9X5P+uUXEBqCRYxhhi9YVzgEfcZCPmJwNu6PB2?=
 =?us-ascii?Q?ZUsHzo8mZ5Z78KCytmX65hSTr5O0SWKiiZ0BajGONBWnEYmIM5ghd/6aYOcp?=
 =?us-ascii?Q?512zmn3rq+/EkU6aOuGc0ZCAsZ34BSIS6875NZXHpLAav+iHq23u8+9LQI2g?=
 =?us-ascii?Q?M+1lMkTD/aBTuqHrlT8YHvCobE9R6pG/WbHgb0G0CmsY0uTCE7Y5LHtH+fwM?=
 =?us-ascii?Q?AIRmz/DE9gIzj13xKiIG37vHbniqT1kYVTOrfUCIlokPqrayFCO+rIUgDPgq?=
 =?us-ascii?Q?FUmOX97xLiEulnas7mU199f6gWDdNP17yeZ7V52LZouki3Jygxij98o2uDOz?=
 =?us-ascii?Q?4QsgIS6iHB97/iXZLPMbUrt/43GhhiDG/LOtYsQStTeExqprDw0OAMszsjr1?=
 =?us-ascii?Q?3tiYqMsL/mT1U2ttYxv96qfVa4WfN/IY31hM89UB0ETdjlgw1lnQjgZKfE3d?=
 =?us-ascii?Q?Au8yP6QWs1ux3mE+kW5cVtXurStLgQff2kMHXelqmiZQtZU9mTHPafKJcl/6?=
 =?us-ascii?Q?aJcx4FkzbTSfP84+imvAwj/uL6GCyUhAqAbrHAyO/xTWuCHBeyWjcWI+im/u?=
 =?us-ascii?Q?0xIwqbgl4dj7UCLgwtSWt5O9RUD/lklomeWSvP42vyrIyg2PMlI/vMTdJirJ?=
 =?us-ascii?Q?g31aK+WSsJ3nD8ho2BuxzwcWvpIt0IOH+UgqksOYmGf6nyFcKvw/KGqZhyi6?=
 =?us-ascii?Q?6TCJlPl7GlJITenEs3AnhAomwifvvCX8KCMAn6YP5cvvgMJDZ/9yc6IUeoJ8?=
 =?us-ascii?Q?ZhXMENfRLDWfoFdYkb9K5yehOyMqF0CY5x/y6XatAr/XrlJaz4sCLIuTOHZb?=
 =?us-ascii?Q?FGmYop7ibxk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3VrRHeX0d8lr4NGxezx5G5e4ya9T1EWyI4RXxOWsrh+ocHlQOhjlMoFeSdG?=
 =?us-ascii?Q?3VS2maS8AcK4AmGwk5IrUYtUaC+PzXnTS6Uh4bNDb2zYfRvqwga/VEQ3YEVK?=
 =?us-ascii?Q?w2C7uqolldWBaY8+9LXX5/PQyUWCZr229LVsa3SN1zCfo93xa0RpvPtYnfTP?=
 =?us-ascii?Q?Irw4C113P+IQeX3Euav84s6O/gqGki9r5c8g79f0znktJ6AcrVF+lc0ntu0j?=
 =?us-ascii?Q?R4yLHg3WJC0s/2ICWN3OTHdlHBUPfOJGFn1b/QnhCdurrjLmzTu4fZbhdZT7?=
 =?us-ascii?Q?GaxpyM/VQmw+sQ+GHy0Xxo/mFlCQH2O8MxxLvT6svYB016L6+VSGcQ9y8yEN?=
 =?us-ascii?Q?tBBFo3+dX8L8l1tZ0f2cdFHJn2SBDt/R3I7nEn7sEkwC/cuJJ34D9INFYNR/?=
 =?us-ascii?Q?0ywvRY9q/n5CvU3PcSUKaLUAz8jdwyC1ba1GMKMzpE0lwVgNN3qmnS1f08li?=
 =?us-ascii?Q?vMYvPdl59yLcIGdHpRbfXYGzKMvJBwfYfXPL2+CPtZNxffzdxoZ0FiMsEtsK?=
 =?us-ascii?Q?O79E+evM641ppgetzOht79dOVQL5tSbBUfaUCIkx1srfg0JgCMEY2FGAQfqz?=
 =?us-ascii?Q?JgEC4xEC/9YbGqbfsShLchFjvB1UblkjBrHwJAXExrFa0dRUIYLsMp3epo9N?=
 =?us-ascii?Q?vh/lzyooNZQL4Oq7+FB24dMb0KVg5E9/Hi2Gi/VGBTbjMRoAUDMNhc9Bxm0x?=
 =?us-ascii?Q?QOypy7lHMNNuPZzubYFVoz5CKC4Tc6pVzJLqMPmZRLGxwR/iDcoWST5xovEI?=
 =?us-ascii?Q?yfEr0KS5TUsuHsVT6Yn1Cd7o3OqDqBi6AiKol1UCy+ja9PXTVy9At668hXHs?=
 =?us-ascii?Q?lh9IAopeH5xiDbqqxLo60oxzzEifm/UGkJAXiNSDe/GocpKe1FexSL/AAFNT?=
 =?us-ascii?Q?EagpmYT89FLZvxmPp42ZpdQfo2o6NwDbyRsVT6dNOn+/YpeO4nhzTe0BkdME?=
 =?us-ascii?Q?6REKaZzMUNdSZyZmrGP4olPH2CVLmosVvyC53fbvypQlufQGSVWINtDGvylh?=
 =?us-ascii?Q?Gh4JjDk6rd7X679/vYae1To8sRGYOsI/91HYRQBwvnY9LNf82mWR78+RlFQ1?=
 =?us-ascii?Q?RQ3xjuH6qO2OzgneK8nlh7f5pkTfRqA9nsshBram2ME0NBgxUzW2UOwRTeRo?=
 =?us-ascii?Q?vFaVX7S3yWTSqunCuQ81k3wcQJD8TgbQ1Y2lm8WX6lEAMcvkvLkHqJWvNcPO?=
 =?us-ascii?Q?erBxQ2I+WztTUfmIJ+w3/sH9dNrTjYsk+M7WSCKYnpzjniYMznPzkhmbTXzB?=
 =?us-ascii?Q?WlZz9wcFv0OLJD0AzGmORT9Pg87RZKfLExqrQrqw2BnXDCpnlJQhbIKtMkmy?=
 =?us-ascii?Q?6PQ1YWtb1zM2hubGvMS3jpiZxIgHCGC4DLvzdPrsMPm4+sse4++yiD6SvqP6?=
 =?us-ascii?Q?+mxn5jLKxfKQINswjcpmBTso7Tb0W7aFQ3UvMM2LRov2St+8ItsFNeBT/dCG?=
 =?us-ascii?Q?hPPJKHl5tkQeSAN11jvZ2T06V2Hp3OoYr7YH//mI7B/vKbIcYUnPhXxTWolf?=
 =?us-ascii?Q?43IwzL6+cY76EWkrwd3Nq0/dZQZ0xamhmcd299dYQK6pf4O6pXLhIQMUJxQT?=
 =?us-ascii?Q?Z2uroyA2m1MgecK3+6LxLaePPxL59p27p/QSbHSQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d117338-d92b-4e28-c8b5-08dd7de1d35f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:58:22.5902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYuZlY0mlof7EkN3elaVac5ENFn5tejQLt91clPhnhd/EvSiuyBwEIjtYL44dEbIbuFwv/dEnHs3An5lpJIwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

Thank you for sharing the API.
Please check out my comments below.

Regards,
Gregory

On Thu, 17 Apr 2025, Harry van Haaren wrote:

> External email: Use caution opening links or attachments
>
>
> This patch is NOT to be considered for merge, it is a demo
> of the Rust APIs for Ethdev. There is no actual implementation
> of the APIs against the DPDK C functions, this is Rust API only.
>
> To test/run the code (and uncomment things to see errors)
> just apply this patch, cd "rust_api_example" and run
> $ cargo run
>
> This will compile the API, and spawn 2x threads to poll on
> two Rxq instances. The comments in the code explain how the
> "Send" and "Sync" attributes are captured per instances of a
> struct (e.g. how RxqHandle -> Rxq restricts thread movement).
>
> Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>
> ---
> rust_api_example/Cargo.toml  |   6 ++
> rust_api_example/src/main.rs | 189 +++++++++++++++++++++++++++++++++++
> 2 files changed, 195 insertions(+)
> create mode 100644 rust_api_example/Cargo.toml
> create mode 100644 rust_api_example/src/main.rs
>
> diff --git a/rust_api_example/Cargo.toml b/rust_api_example/Cargo.toml
> new file mode 100644
> index 0000000000..0137826340
> --- /dev/null
> +++ b/rust_api_example/Cargo.toml
> @@ -0,0 +1,6 @@
> +[package]
> +name = "rust_api_example"
> +version = "0.1.0"
> +edition = "2021"
> +
> +[dependencies]
> diff --git a/rust_api_example/src/main.rs b/rust_api_example/src/main.rs
> new file mode 100644
> index 0000000000..8d0de50c30
> --- /dev/null
> +++ b/rust_api_example/src/main.rs
> @@ -0,0 +1,189 @@
> +// Outline for safe DPDK API bindings
> +//  - None of the APIs are actually implemented, this is API design only
> +//  - This demo runs 2x threads on 2x Rxqs, and cannot accidentally poll incorrectly
> +
> +pub mod dpdk {
> +    pub mod eth {
> +        use super::Mempool;
> +
> +        #[derive(Debug)]
> +        pub struct TxqHandle {/* todo: but same as Rxq */}
> +
> +        // Handle allows moving between threads, its not polling!
> +        #[derive(Debug)]
> +        pub struct RxqHandle {
> +            port: u16,
> +            queue: u16,
> +        }
> +
> +        impl RxqHandle {
> +            pub(crate) fn new(port: u16, queue: u16) -> Self {
> +                RxqHandle { port, queue }
> +            }
> +
> +            // This function is the key to the API design: it ensures the rx_burst()
> +            // function is only available via the Rxq struct, after enable_polling() has been called.
> +            // It "consumes" (takes "self" as a parameter, not a '&' reference!) which essentially
> +            // destroys/invalidates the handle from the Application level code.
> +
> +            // It returns an Rxq instance, which has the PhantomData to encode the threading requirements,
> +            // and the Rxq has the rx_burst() function: this allows the application to recieve packets.
> +            pub fn enable_polling(self) -> Rxq {
> +                Rxq {
> +                    handle: self,
> +                    _phantom: std::marker::PhantomData,
> +                }
> +            }
> +        }
> +
> +        #[derive(Debug)]
> +        pub struct Rxq {
> +            handle: RxqHandle,
> +            // This "PhantomData" tells the rust compiler to Pretend the Rc<()> is in this struct
> +            // but in practice it is a Zero-Sized-Type, so takes up no space. It is a compile-time
> +            // language technique to ensure the struct is not moved between threads. This encodes
> +            // the API requirement "don't poll from multiple threads without synchronisation (e.g. Mutex)"
> +            _phantom: std::marker::PhantomData<std::rc::Rc<()>>,
> +        }
> +
> +        impl Rxq {
> +            // TODO: datapath Error types should be lightweight, not String. Here we return ().
> +            pub fn rx_burst(&mut self, _mbufs: &mut [u8]) -> Result<usize, ()> {
> +                // TODO: Design the Mbuf struct wrapper, and how to best return a batch
> +                //  e.g.: investigate "ArrayVec" crate for safe & fixed sized, stack allocated arrays
> +                //
> +                // There is work to do here, but I want to communicate the general DPDK/EAL/Eth/Rxq concepts
> +                // now, this part is not done yet: it is likely the hardest/most performance critical.
> +                //
> +                // call rte_eth_rx_burst() here
> +                println!(
> +                    "[thread: {:?}] rx_burst: port {} queue {}",
> +                    std::thread::current().id(),
> +                    self.handle.port,
> +                    self.handle.queue
> +                );
> +                Ok(0)
> +            }
> +        }
> +
> +        #[derive(Debug)]
> +        pub struct Port {
> +            id: u16,
> +            rxqs: Vec<RxqHandle>,
> +            txqs: Vec<TxqHandle>,
> +        }
> +
> +        impl Port {
> +            // pub(crate) here ensures outside this crate users cannot call this function
> +            pub(crate) fn from_u16(id: u16) -> Self {
> +                Port {
> +                    id,
> +                    rxqs: Vec::new(),
> +                    txqs: Vec::new(),
> +                }
> +            }
> +
> +            pub fn rxqs(&mut self, rxq_count: u16, _mempool: Mempool) -> Result<(), String> {
> +                for q in 0..rxq_count {
> +                    // call rte_eth_rx_queue_setup() here
> +                    self.rxqs.push(RxqHandle::new(self.id, q));
> +                }
> +                Ok(())
> +            }
> +
> +            pub fn start(&mut self) -> (Vec<RxqHandle>, Vec<TxqHandle>) {
> +                // call rte_eth_dev_start() here, then give ownership of Rxq/Txq to app

After a call to Port::start, Rx and Tx queues are detached from it's port.
With that model how rte_eth_dev_stop() and subsequent rte_eth_dev_start()
DPDK calls can be implemented ?

> +                (
> +                    std::mem::take(&mut self.rxqs),
> +                    std::mem::take(&mut self.txqs),
> +                )
> +            }
> +        }
> +    }
> +
> +    #[derive(Debug, Clone)]
> +    // Mempool is a long-life object, which many other DPDK things refer to (e.g. rxq config)
> +    // Having a Rust lifetime attached to it (while technically correct) would complicate the
> +    // code a LOT, and for little value. This is a tradeoff - happy to discuss more if we want.
> +    // The choice here is to derive "Clone", allowing handing over multiple instances of the
> +    // same Mempool, similar to how Arc<Mempool> would work, but without the reference counting.
> +    pub struct Mempool {}
> +
> +    impl Mempool {
> +        pub fn new(_size: usize) -> Self {
> +            Self {}
> +        }
> +    }
> +
> +    #[derive(Debug)]
> +    pub struct Eal {
> +        eth_ports: Option<Vec<eth::Port>>,
> +    }
> +
> +    impl Eal {
> +        //  allow init once,
> +        pub fn init() -> Result<Self, String> {
> +            // EAL init() will do PCI probe and VDev enumeration will find/create eth ports.
> +            // This code should loop over the ports, and build up Rust structs representing them
> +            let eth_port = vec![eth::Port::from_u16(0)];
> +            Ok(Eal {
> +                eth_ports: Some(eth_port),
> +            })
> +        }
> +
> +        // API to get eth ports, taking ownership. It can be called once.
> +        // The return will be None for future calls
> +        pub fn take_eth_ports(&mut self) -> Option<Vec<eth::Port>> {
> +            self.eth_ports.take()
> +        }
> +    }
> +
> +    impl Drop for Eal {
> +        fn drop(&mut self) {
> +            // todo: rte_eal_cleanup()
> +        }
> +    }
> +} // DPDK mod
> +
> +fn main() {
> +    let mut dpdk = dpdk::Eal::init().expect("dpdk must init ok");
> +    let rx_mempool = dpdk::Mempool::new(4096);
> +
> +    let mut ports = dpdk.take_eth_ports().expect("take eth ports ok");

Eal::take_eth_ports() resets EAL ports.
A call to rte_dev_probe() will ether fail, because Eal::eth_ports is None 
or create another port-0, depending on implementation.

> +    let mut p = ports.pop().unwrap();
> +
> +    p.rxqs(2, rx_mempool).expect("rxqs setup ok");
> +    println!("{:?}", p);
> +
> +    let (mut rxqs, _txqs) = p.start();
> +    println!("rxqs: {:?}", rxqs);
> +
> +    let rxq1 = rxqs.pop().unwrap();
> +    let rxq2 = rxqs.pop().unwrap();
> +
> +    // spawn a new thread to use rxq1. This demonstrates that the RxqHandle
> +    // type can move between threads - it is not tied to the thread that created it.
> +    std::thread::spawn(move || {
> +        // Uncomment this: it fails to compile!
> +        //   - Rxq2 would be used by this newly-spawned thread
> +        //     -- specifically the variable was "moved" into this thread
> +        //   - it is also used below (by the main thread)
> +        // "value used after move" is the error, on the below code
> +        // let mut rxq = rxq2.enable_polling();
> +
> +        // see docs on enable_polling above to understand how the enable_polling()
> +        // function helps to achieve the thread-safety-at-compile-time goal.
> +        let mut rxq = rxq1.enable_polling();
> +        loop {
> +            let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
> +            std::thread::sleep(std::time::Duration::from_millis(1000));
> +        }
> +    });
> +
> +    // main thread polling rxq2
> +    let mut rxq = rxq2.enable_polling();
> +    loop {
> +        let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
> +        std::thread::sleep(std::time::Duration::from_millis(1000));
> +    }
> +}
> --
> 2.34.1
>
>
